local pid = vim.fn.getpid()
local omnisharp_bin = "/Users/kylesurowiec/.local/share/nvim/mason/packages/omnisharp/omnisharp"

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "Hoffs/omnisharp-extended-lsp.nvim" },
    },
    init = function()
      return {
        handlers = {
          ["textDocument/definition"] = require("omnisharp_extended").handler,
        },
        cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
      }
    end,
  },
}
