return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "omnisharp",
        "rust-analyzer",
        "tailwindcss-language-server",
      },
    },
  },
}
