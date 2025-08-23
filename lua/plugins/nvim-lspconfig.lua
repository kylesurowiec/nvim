return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.inlay_hints = {
        enabled = false,
      }

      opts.servers = opts.servers or {}

      opts.servers.vtsls = {
        settings = {
          typescript = {
            preferences = {
              disableImportGroupMerging = true,
            },
          },
        },
      }

      opts.servers.vtsls.settings.javascript = vim.tbl_deep_extend(
        "force",
        {},
        opts.servers.vtsls.settings.typescript,
        opts.servers.vtsls.settings.javascript or {}
      )

      -- Fix omnisharp command path
      if opts.servers.omnisharp then
        opts.servers.omnisharp.cmd = {
          vim.fn.expand("~/.local/share/nvim/mason/bin/OmniSharp"),
          "--languageserver",
          "--hostPID",
          tostring(vim.fn.getpid()),
        }
      end
    end,
  },
}
