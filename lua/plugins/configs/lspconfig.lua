local cmp_nvim_lsp = require("cmp_nvim_lsp")

local keymap = vim.keymap.set

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  
  -- LSP keybinds
  keymap("n", "gD", vim.lsp.buf.declaration, opts)
  keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
  keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
  keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)
  keymap("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
  keymap({ "n", "v" }, "<leader>ca", function() _G.code_action_with_backdrop() end, opts)
  keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
  keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
  keymap("n", "<leader>d", vim.diagnostic.open_float, opts)
  keymap("n", "[d", vim.diagnostic.goto_prev, opts)
  keymap("n", "]d", vim.diagnostic.goto_next, opts)
  keymap("n", "K", vim.lsp.buf.hover, opts)
  keymap("n", "<leader>rs", ":LspRestart<CR>", opts)
end

local capabilities = cmp_nvim_lsp.default_capabilities()

-- Configure diagnostics
vim.diagnostic.config({
  underline = true,
  virtual_text = {
    prefix = '●',
    source = "if_many",
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
  signs = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Setup servers installed by Mason
local servers = { "ts_ls", "html", "cssls", "tailwindcss", "lua_ls", "pyright", "rust_analyzer", "eslint", "clangd", "zls" }

for _, server in ipairs(servers) do
  local server_config = {
    capabilities = capabilities,
    on_attach = on_attach,
  }
  
  -- Enhanced TypeScript configuration
  if server == "ts_ls" then
    server_config.on_attach = function(client, bufnr)
      -- Disable tsserver formatting in favor of prettier
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      on_attach(client, bufnr)
    end
    server_config.settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'literal',
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = false,
        },
        suggest = {
          includeCompletionsForModuleExports = true,
        },
      },
    }
  end
  
  -- Special config for ESLint
  if server == "eslint" then
    server_config.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      -- Auto-fix on save for JS/TS files
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          local filetype = vim.bo[bufnr].filetype
          if filetype == "javascript" or filetype == "javascriptreact" or
             filetype == "typescript" or filetype == "typescriptreact" then
            vim.lsp.buf.execute_command({
              command = 'eslint.applyAllFixes',
              arguments = {
                {
                  uri = vim.uri_from_bufnr(bufnr),
                  version = vim.lsp.util.buf_versions[bufnr],
                },
              },
            })
          end
        end,
      })
    end
  end

  -- Special config for lua_ls
  if server == "lua_ls" then
    server_config.settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
      },
    }
  end
  
  -- Special config for clangd
  if server == "clangd" then
    server_config.cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--fallback-style=Microsoft",
    }
    server_config.init_options = {
      usePlaceholders = true,
      completeUnimported = true,
      clangdFileStatus = true,
    }
    server_config.capabilities.textDocument.semanticHighlighting = true
  end
  
  -- Special config for ZLS (Zig Language Server)
  if server == "zls" then
    server_config.settings = {
      zls = {
        enable_snippets = true,
        enable_ast_check_diagnostics = true,
        enable_autofix = true,
        enable_import_embedfile_argument_completions = true,
        warn_style = true,
        highlight_global_var_declarations = true,
        -- Point ZLS to our zig installation
        zig_exe_path = vim.fn.expand("~/.local/bin/zig"),
      }
    }
  end

  -- Special config for Tailwind CSS
  if server == "tailwindcss" then
    server_config.filetypes = {
      "html", "css", "scss", "sass", "postcss",
      "javascript", "javascriptreact",
      "typescript", "typescriptreact",
      "vue", "svelte", "astro",
      "templ", -- Go templ files
      "markdown",
    }
    server_config.settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            -- Match ANY string literal (broad detection for object values, variables, etc.)
            { "[\"'`]([^\"'`]*)[\"'`]" },
            -- Support for class attribute variations (more specific, higher priority)
            { "class[:]\\s*['\"`]([^'\"`]*)['\"`]" },
            { "className[:]\\s*['\"`]([^'\"`]*)['\"`]" },
            -- Support for template literals
            { "tw`([^`]*)" },
            { "tw\\.[^`]+`([^`]*)`" },
            { "tw\\(.*?\\).*?`([^`]*)" },
            -- Support for clsx/classnames
            { "clsx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            { "classnames\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
            { "cn\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)" },
          },
        },
        validate = true,
        lint = {
          cssConflict = "warning",
          invalidApply = "error",
          invalidScreen = "error",
          invalidVariant = "error",
          invalidConfigPath = "error",
          invalidTailwindDirective = "error",
          recommendedVariantOrder = "warning",
        },
      },
    }
    server_config.init_options = {
      userLanguages = {
        templ = "html",
      },
    }
  end

  vim.lsp.config(server, server_config)
  vim.lsp.enable(server)
end

-- Ensure virtual_text is enabled (in case something disabled it)
vim.diagnostic.config({
  virtual_text = {
    prefix = '●',
    source = "if_many", 
    format = function(diagnostic)
      return diagnostic.message
    end,
  },
})

-- Create autocmd to ensure virtual_text stays enabled
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function()
    vim.schedule(function()
      vim.diagnostic.config({
        virtual_text = {
          prefix = '●',
          source = "if_many", 
          format = function(diagnostic)
            return diagnostic.message
          end,
        },
      })
    end)
  end,
})

-- Configure Roslyn (C#) LSP settings
vim.lsp.config("roslyn", {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["csharp|formatting"] = {
      dotnet_organize_imports_on_format = true,
    },
    ["csharp|completion"] = {
      dotnet_show_completion_items_from_unimported_namespaces = true,
      dotnet_show_name_completion_suggestions = true,
    },
  },
})

-- Load C++ specific configurations
require("plugins.configs.cpp")

-- Custom code action with backdrop
local function code_action_with_backdrop()
  -- Clean up any existing backdrop first
  if vim.g.code_action_backdrop and vim.api.nvim_win_is_valid(vim.g.code_action_backdrop.win) then
    vim.api.nvim_win_close(vim.g.code_action_backdrop.win, true)
    vim.g.code_action_backdrop = nil
  end
  
  -- Clear any existing autocmds
  vim.api.nvim_create_augroup("CodeActionBackdrop", { clear = true })
  
  -- First, check if code actions are available
  local context = { diagnostics = vim.lsp.diagnostic.get_line_diagnostics() }
  local params = vim.lsp.util.make_range_params(0, "utf-16")
  params.context = context
  
  local results = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
  
  -- Check if any results contain non-empty actions
  local has_actions = false
  if results then
    for _, res in pairs(results) do
      if res.result and not vim.tbl_isempty(res.result) then
        has_actions = true
        break
      end
    end
  end
  
  -- If no actions available, just call normal code action (shows "No code actions available")
  if not has_actions then
    vim.lsp.buf.code_action()
    return
  end
  
  -- Actions exist - create backdrop and setup cleanup
  local cleanup_backdrop = function()
    if vim.g.code_action_backdrop and vim.api.nvim_win_is_valid(vim.g.code_action_backdrop.win) then
      vim.api.nvim_win_close(vim.g.code_action_backdrop.win, true)
      vim.g.code_action_backdrop = nil
      -- Clear autocmds after cleanup
      vim.api.nvim_create_augroup("CodeActionBackdrop", { clear = true })
    end
  end
  
  -- Create backdrop
  local backdrop_buf = vim.api.nvim_create_buf(false, true)
  local backdrop_win = vim.api.nvim_open_win(backdrop_buf, false, {
    relative = 'editor',
    row = 0,
    col = 0,
    width = vim.o.columns,
    height = vim.o.lines,
    style = 'minimal',
    zindex = 50, -- Low z-index to be behind all popups
  })
  
  -- Set backdrop appearance with proper highlighting
  vim.api.nvim_set_option_value('winblend', 30, { win = backdrop_win })
  vim.api.nvim_set_option_value('winhighlight', 'Normal:NormalFloat', { win = backdrop_win })
  vim.api.nvim_buf_set_lines(backdrop_buf, 0, -1, false, { string.rep(' ', vim.o.columns) })
  
  -- Store backdrop info globally for cleanup
  vim.g.code_action_backdrop = { buf = backdrop_buf, win = backdrop_win }
  
  -- Create autocmds for cleanup
  local group = vim.api.nvim_create_augroup("CodeActionBackdrop", { clear = true })
  
  -- Cleanup when windows close
  vim.api.nvim_create_autocmd("WinClosed", {
    group = group,
    callback = function()
      vim.defer_fn(function()
        -- Check if any select/input windows are still open
        local ui_open = false
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_is_valid(win) then
            local buf = vim.api.nvim_win_get_buf(win)
            local ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
            -- Check for various dressing filetypes
            if ft == 'DressingSelect' or ft == 'DressingInput' or string.match(ft, 'dressing') then
              ui_open = true
              break
            end
          end
        end
        if not ui_open then
          cleanup_backdrop()
        end
      end, 150)
    end,
  })
  
  -- Cleanup on buffer events (when selection is made)
  vim.api.nvim_create_autocmd({"BufHidden", "BufUnload"}, {
    group = group,
    callback = function(args)
      local ft = vim.api.nvim_get_option_value('filetype', { buf = args.buf })
      if ft == 'DressingSelect' then
        vim.defer_fn(cleanup_backdrop, 100)
      end
    end,
  })
  
  -- Cleanup on escape key in select window
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "DressingSelect",
    callback = function(args)
      -- Set up escape key to cleanup backdrop
      vim.keymap.set('n', '<Esc>', function()
        cleanup_backdrop()
        vim.cmd('close')
      end, { buffer = args.buf, silent = true })
    end,
  })
  
  -- Call normal code action to show UI
  vim.lsp.buf.code_action()
end

-- Make the backdrop version globally available
_G.code_action_with_backdrop = code_action_with_backdrop