return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "omnisharp",
        "prettierd",
        "rust-analyzer",
        "tailwindcss-language-server",
      },
    },
  },
}
