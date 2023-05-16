return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        eslint = {},
        tailwindcss = {},
      },
      setup = {
        eslint = function()
          require("lazyvim.util").on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingPrettier = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingPrettier = false
            end
          end)
        end,
      },
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
}
