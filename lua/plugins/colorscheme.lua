return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    lazy = false,
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").setup({})
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({})
    end,
  },
  {
    "lalitmee/cobalt2.nvim",
    event = { "ColorSchemePre" }, -- if you want to lazy load
    dependencies = { "tjdevries/colorbuddy.nvim", tag = "v1.0.0" },
    init = function()
      require("colorbuddy").colorscheme("cobalt2")
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "cobalt2",
    },
  },
}
