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
}
