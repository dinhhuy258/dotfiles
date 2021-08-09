local M = {}

M.setup = function()
  vim.g.startify_custom_header = {
    "   *--------------------------------------------------*",
    "   |      __ __            ___                        |",
    "   |     / // /_ ____ __  / _ \\__ _____  ___  ___ _   |",
    "   |    / _  / // / // / / // / // / _ \\/ _ \\/ _ `/   |",
    "   |   /_//_/\\_,_/\\_, / /____/\\_,_/\\___/_//_/\\_, /    |",
    "   |             /___/                      /___/     |",
    "   |                                                  |",
    "   *--------------------------------------------------*",
    "          o",
    "           o   ^__^",
    "            o  (oo)\\_______",
    "               (__)\\       )\\/\\",
    "                   ||----w |",
    "                   ||     ||",
  }

  vim.g.startify_lists = {
    { ["type"] = "dir", ["header"] = { "   Current Directory " .. vim.call "getcwd" } },
    { ["type"] = "sessions", ["header"] = { "   Sessions" } },
    { ["type"] = "bookmarks", ["header"] = { "   Bookmarks" } },
  }

  vim.g.startify_bookmarks = {
    { ["z"] = "~/.zshrc" },
  }

  vim.g.startify_session_dir = "~/.config/nvim/session"
  vim.g.startify_session_autoload = 1
  vim.g.startify_session_delete_buffers = 1
  vim.g.startify_change_to_vcs_root = 1
  vim.g.startify_fortune_use_unicode = 1
  vim.g.startify_session_persistence = 1
  vim.g.startify_enable_special = 0
  vim.g.webdevicons_enable_startify = 1
end

return M
