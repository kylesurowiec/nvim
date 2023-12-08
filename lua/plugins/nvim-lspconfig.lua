local pid = vim.fn.getpid()

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "Hoffs/omnisharp-extended-lsp.nvim" },
    },
    opts = {
      servers = {
        omnisharp = {
          cmd = { "omnisharp", "--languageserver", "--hostPID", tostring(pid) },
          capabilities = { textDocument = { formatting = true } },
          handlers = {
            ["textDocument/definition"] = function(...)
              return require("omnisharp_extended").handler(...)
            end,
          },
          on_attach = function(client, bufnr)
            vim.keymap.set(
              "n",
              "gd",
              "<cmd>lua require('omnisharp_extended').telescope_lsp_definitions()<cr>",
              { desc = "Goto definition (omnisharp)", buffer = bufnr }
            )

            local function toSnakeCase(str)
              return string.gsub(str, "%s*[- ]%s*", "_")
            end

            local tokenModifiers =
              client.server_capabilities.semanticTokensProvider.legend.tokenModifiers

            for i, v in ipairs(tokenModifiers) do
              tokenModifiers[i] = toSnakeCase(v)
            end

            local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes

            for i, v in ipairs(tokenTypes) do
              tokenTypes[i] = toSnakeCase(v)
            end
          end,
        },
      },
    },
  },
}
