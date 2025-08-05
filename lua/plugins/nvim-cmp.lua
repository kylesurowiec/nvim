return {
  {
    "hrsh7th/nvim-cmp",
    commit = "b356f2c",
    pin = true,
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    opts = function(_, opts)
      opts.completion = { autocomplete = false }
      opts.experimental = { ghost_text = false }

      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item)
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },
}
