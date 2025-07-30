-- LSP autocmds and on_attach setup
local M = {}

function M.setup()
  -- Create autocommand group for LSP
  local lsp_group = vim.api.nvim_create_augroup('ModernLSP', { clear = true })
  
  -- LspAttach autocmd - modern way to handle on_attach
  vim.api.nvim_create_autocmd('LspAttach', {
    group = lsp_group,
    callback = function(args)
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      local bufnr = args.buf
      
      -- Set up buffer-local keymaps
      require('lsp.keymaps').setup_buffer_keymaps(client, bufnr)
      
      -- Enable inlay hints if supported
      if client.supports_method('textDocument/inlayHint') then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end

      -- Enable auto-completion if supported
      if client.supports_method('textDocument/completion') then
        vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
      end

      -- Document highlighting
      if client.supports_method('textDocument/documentHighlight') then
        local highlight_group = vim.api.nvim_create_augroup('LSPDocumentHighlight_' .. bufnr, { clear = true })
        
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = bufnr,
          group = highlight_group,
          callback = vim.lsp.buf.document_highlight,
        })
        
        vim.api.nvim_create_autocmd('CursorMoved', {
          buffer = bufnr,
          group = highlight_group,
          callback = vim.lsp.buf.clear_references,
        })
      end

      -- Auto-format on save (if server supports it and no willSaveWaitUntil)
      if not client.supports_method('textDocument/willSaveWaitUntil')
          and client.supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
          group = lsp_group,
          buffer = bufnr,
          callback = function()
            -- Only format if conform.nvim doesn't handle this filetype
            local conform_ok, conform = pcall(require, 'conform')
            if conform_ok then
              local formatters = conform.list_formatters(bufnr)
              if #formatters > 0 then
                return -- Let conform handle formatting
              end
            end
            
            vim.lsp.buf.format({ 
              bufnr = bufnr, 
              id = client.id, 
              timeout_ms = 1000 
            })
          end,
        })
      end

      -- Disable Go formatting if using conform.nvim/go.nvim
      if vim.bo[bufnr].filetype == "go" and client.name == "gopls" then
        client.server_capabilities.documentFormattingProvider = false
      end

      -- Plugin integrations
      local navbuddy_ok, navbuddy = pcall(require, 'nvim-navbuddy')
      if navbuddy_ok then
        navbuddy.attach(client, bufnr)
      end

      -- Notify about LSP attachment
      vim.notify(
        string.format('LSP client "%s" attached to buffer %d', client.name, bufnr),
        vim.log.levels.INFO,
        { title = 'LSP' }
      )
    end,
  })

  -- LspDetach autocmd
  vim.api.nvim_create_autocmd('LspDetach', {
    group = lsp_group,
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local bufnr = args.buf
      
      -- Clean up document highlighting autocmds
      local highlight_group_name = 'LSPDocumentHighlight_' .. bufnr
      pcall(vim.api.nvim_del_augroup_by_name, highlight_group_name)
      
      -- Disable completion if it was enabled
      vim.lsp.completion.enable(false, args.data.client_id, bufnr)
      
      -- Disable inlay hints
      vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
      
      if client then
        vim.notify(
          string.format('LSP client "%s" detached from buffer %d', client.name, bufnr),
          vim.log.levels.INFO,
          { title = 'LSP' }
        )
      end
    end,
  })

  -- Handle dynamic capability registration
  vim.lsp.handlers['client/registerCapability'] = (function(original_handler)
    return function(err, res, ctx)
      local result = original_handler(err, res, ctx)
      local client = vim.lsp.get_client_by_id(ctx.client_id)
      
      if not client then
        return result
      end
      
      -- Re-attach to all buffers when capabilities change
      for bufnr, _ in pairs(client.attached_bufders or {}) do
        -- Trigger LspAttach-like behavior for newly registered capabilities
        if vim.api.nvim_buf_is_valid(bufnr) then
          vim.api.nvim_exec_autocmds('User', {
            pattern = 'LspCapabilityUpdate',
            data = { client_id = ctx.client_id, bufnr = bufnr }
          })
        end
      end
      
      return result
    end
  end)(vim.lsp.handlers['client/registerCapability'])
end

return M