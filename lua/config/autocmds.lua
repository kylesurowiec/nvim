-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Override LspRestart after all plugins load to filter out Copilot and other non-restartable LSP clients
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Delete the existing LspRestart command from nvim-lspconfig
    pcall(vim.api.nvim_del_user_command, "LspRestart")

    -- Create our improved version
    vim.api.nvim_create_user_command("LspRestart", function(opts)
      -- List of LSP clients that should be excluded from restart
      local exclude_clients = {
        "copilot", -- copilot.lua
        "GitHub Copilot", -- copilot.vim
        "null-ls", -- null-ls clients don't have server configs
      }

      local target_client = opts.args and opts.args ~= "" and opts.args or nil

      if target_client then
        -- If a specific client is targeted, check if it's allowed
        local found = false
        for _, excluded in ipairs(exclude_clients) do
          if target_client == excluded then
            vim.notify("Cannot restart " .. target_client .. " (not a configured LSP server)", vim.log.levels.WARN)
            return
          end
        end
        -- Let the original command handle named clients
        vim.cmd("LspStop " .. target_client)
        vim.defer_fn(function()
          vim.cmd("LspStart " .. target_client)
        end, 1000)
      else
        -- Restart all valid LSP clients
        local clients = vim.lsp.get_clients({ bufnr = 0 })
        local restarted = {}

        for _, client in ipairs(clients) do
          local should_exclude = false
          for _, excluded in ipairs(exclude_clients) do
            if client.name == excluded then
              should_exclude = true
              break
            end
          end

          if not should_exclude then
            vim.lsp.stop_client(client.id, true)
            table.insert(restarted, client.name)
          end
        end

        if #restarted > 0 then
          vim.defer_fn(function()
            for _, name in ipairs(restarted) do
              vim.cmd("LspStart " .. name)
            end
          end, 1000)
          vim.notify("Restarted LSP clients: " .. table.concat(restarted, ", "))
        else
          vim.notify("No LSP clients to restart", vim.log.levels.INFO)
        end
      end
    end, {
      nargs = "?",
      complete = function()
        local clients = vim.lsp.get_clients()
        local names = {}
        local exclude_clients = { "copilot", "GitHub Copilot", "null-ls" }

        for _, client in ipairs(clients) do
          local should_exclude = false
          for _, excluded in ipairs(exclude_clients) do
            if client.name == excluded then
              should_exclude = true
              break
            end
          end
          if not should_exclude then
            table.insert(names, client.name)
          end
        end
        return names
      end,
      desc = "Restart LSP clients (excluding Copilot and other non-restartable clients)",
    })
  end,
})
