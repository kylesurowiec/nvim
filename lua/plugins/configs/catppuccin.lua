require("catppuccin").setup({
  flavour = "mocha",
  term_colors = true,
  styles = {
    comments = { "italic" },
    conditionals = { "italic" },
    keywords = { "italic" },
    functions = {},
    strings = {},
    variables = {},
  },
  integrations = {
    cmp = true,
    gitsigns = true,
    treesitter = true,
    telescope = { enabled = true },
    mini = { enabled = true },
    noice = true,
    which_key = true,
    native_lsp = {
      enabled = true,
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
  },
})
