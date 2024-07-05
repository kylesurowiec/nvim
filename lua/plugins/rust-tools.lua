return {
  {
    "simrat39/rust-tools.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
    },
    opts = {
      tools = {
        autoSetHints = true,
        inlay_hints = {
          show_parameter_hints = false,
          parameter_hints_prefix = "",
          other_hints_prefix = "",
        },
      },
      -- Rust-analyzer w/rust-tools
      server = {
        cmd = { "rust-analyzer" },
        on_attach = function(_, bufnr)
          -- Setup format on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("RustFmt", { clear = true }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({
                timeout_ms = 2000,
                filter = function(client)
                  return client.name == "rust_analyzer"
                end,
              })
            end,
          })
          -- Key mapping for :RustHoverActions
          vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>ra", ":RustHoverActions<CR>", {
            noremap = true,
            silent = true,
            desc = "Rust Hover Actions",
          })
        end,
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      },
    },
  },
}
