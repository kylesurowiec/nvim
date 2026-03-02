local mason = require("mason")

mason.setup({
  registries = {
    "github:mason-org/mason-registry",
    "github:Crashdummyy/mason-registry", -- For roslyn
  },
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
  -- Environment and PATH configuration for npm/node tools
  install_root_dir = vim.fn.stdpath("data") .. "/mason",
  PATH = "prepend", -- Prepend Mason bin to PATH
})

-- Mason-lspconfig setup moved to plugins/init.lua to avoid duplicate configuration

-- Mason-tool-installer setup moved to plugins/init.lua to avoid circular dependencies