-- Reference: https://github.com/evanpurkhiser/image-paste.nvim

local keymaps = require "config.keymaps"

local M = {}

local image_name = "imgur.png"
local imgur_access_token = vim.env.IMGUR_ACCESS_TOKEN

local function has_clipboard_img()
  local handle = io.popen "pngpaste -b 2>&1"
  if handle == nil then
    return false
  end

  local result = handle:read "*a"

  handle:close()

  -- check if the output is clipboard img
  return string.sub(result, 1, 9) == "iVBORw0KG" -- magic png number in base64
end

local function compress_image()
  -- Create temporary file names
  local temp_input = os.tmpname()
  local temp_output = temp_input .. ".jpg"

  -- Save clipboard content to temporary input file
  os.execute("pngpaste " .. temp_input)

  -- Compress image using ffmpeg
  local compress_command = string.format("ffmpeg -i %s %s", temp_input, temp_output)
  os.execute(compress_command .. " > /dev/null 2>&1")

  -- Copy compressed image back to clipboard
  os.execute("osascript -e 'set the clipboard to (read (POSIX file \"" .. temp_output .. "\") as JPEG picture)'")

  -- Remove temporary files
  os.remove(temp_input)
  os.remove(temp_output)

  -- Check for errors
  if vim.v.shell_error ~= 0 then
    return false
  end

  return true
end

function M.paste_image()
  -- check if the clipboard has image
  if not has_clipboard_img() then
    vim.notify("There is nothing to paste.", vim.log.levels.ERROR)

    return
  end

  -- compress image before uploading to imgur
  if not compress_image() then
    vim.notify("Failed to compress image.", vim.log.levels.ERROR)

    return
  end

  local template_md = "![%s](%s)"

  local placeholder_alt = string.format("Uploading %s…", image_name)
  local placeholder = string.format(template_md, placeholder_alt, "")

  -- Insert the upload template
  local buffer = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(buffer, row - 1, col, row - 1, col, { placeholder })
  vim.api.nvim_win_set_cursor(0, { row, col + placeholder:len() + 1 })

  -- Mark the location of the template for replacing later
  local mark_ns = vim.api.nvim_create_namespace ""
  local mark_id = vim.api.nvim_buf_set_extmark(
    buffer,
    mark_ns,
    row - 1,
    col,
    { end_col = col + placeholder:len(), hl_group = "Whitespace" }
  )

  local upload_command = string.format(
    [[pngpaste - \
      | curl \
        --silent \
        --fail \
        --request POST \
        --form "image=@-" \
        --header "Authorization: Bearer %s" \
        "https://api.imgur.com/3/upload" \
      | jq --raw-output .data.link
  ]],
    imgur_access_token
  )

  local url = nil

  -- Start uploading
  vim.fn.jobstart(upload_command, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      url = vim.fn.join(data):gsub("^%s*(.-)%s*$", "%1")
    end,
    on_exit = function(_, exit_code)
      local failed = url == "" or exit_code ~= 0
      local replacement = ""

      -- Create the replacement string
      if not failed then
        replacement = string.format(template_md, image_name, url)
      else
        vim.notify("Failed to upload or paste image.", vim.log.levels.ERROR)
      end

      -- Locate the mark
      local mark_row, mark_col = unpack(vim.api.nvim_buf_get_extmark_by_id(buffer, mark_ns, mark_id, {}))

      -- Update the line containing the mark
      vim.api.nvim_buf_del_extmark(buffer, mark_ns, mark_id)
      vim.api.nvim_buf_set_text(buffer, mark_row, mark_col, mark_row, mark_col + placeholder:len(), { replacement })
    end,
  })
end

function M.setup()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
      vim.api.nvim_create_user_command("PasteImage", function()
        M.paste_image()
      end, {
        bang = true,
        nargs = "*",
      })
    end,
  })
end

return M
