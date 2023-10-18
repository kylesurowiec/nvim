return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "prettierd",
        "rust-analyzer",
        "tailwindcss-language-server",
        "typescript-language-server",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {},
        tailwindcss = {},
        omnisharp = {},
      },
    },
    {
      "NvChad/nvim-colorizer.lua",
      opts = {
        user_default_options = {
          tailwind = true,
        },
      },
    },
    {
      "L3MON4D3/LuaSnip",
      opts = {
        history = false,
      },
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
      },
      opts = function(_, opts)
        local format_kinds = opts.formatting.format
        opts.formatting.format = function(entry, item)
          format_kinds(entry, item)
          return require("tailwindcss-colorizer-cmp").formatter(entry, item)
        end
      end,
    },
  },
}
