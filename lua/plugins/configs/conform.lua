local conform = require("conform")

conform.setup({
  formatters = {
    -- Custom Zig formatter using installed zig binary
    zig_fmt = {
      command = vim.fn.expand("~/.local/bin/zig"),
      args = { "fmt", "--stdin" },
      stdin = true,
    },
  },
  formatters_by_ft = {
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    css = { "prettierd" },
    scss = { "prettierd" },
    html = { "prettierd" },
    markdown = { "prettierd" },
    yaml = { "prettierd" },
    -- cs = { "csharpier" }, -- Removed: Use LSP formatting instead
    -- C++ formatting
    c = { "clang_format" },
    cpp = { "clang_format" },
    objc = { "clang_format" },
    objcpp = { "clang_format" },
    -- Zig formatting (uses built-in zig fmt)
    zig = { "zig_fmt" },
  },
  format_on_save = function(bufnr)
    local filetype = vim.bo[bufnr].filetype
    -- C# needs longer timeout for OmniSharp
    if filetype == "cs" then
      return {
        timeout_ms = 10000,
        lsp_format = "fallback",
      }
    end
    return {
      timeout_ms = 5000,
      lsp_format = "fallback",
    }
  end,
})

-- Keymap for manual formatting
vim.keymap.set({ "n", "v" }, "<leader>mp", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 5000,
  })
end, { desc = "Format file or range (in visual mode)" })