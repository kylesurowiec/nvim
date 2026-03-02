-- Enhanced filetype detection for React/TypeScript files
vim.filetype.add({
  extension = {
    -- Ensure proper detection of React files
    tsx = "typescriptreact",
    jsx = "javascriptreact",
    -- Additional JS variants
    mjs = "javascript",
    cjs = "javascript",
    -- JSON with comments
    jsonc = "jsonc",
    -- CSS variants
    scss = "scss",
    sass = "sass",
  },
  filename = {
    -- Common config files
    ['.eslintrc'] = 'json',
    ['.prettierrc'] = 'json',
    ['tsconfig.json'] = 'jsonc',
    ['jsconfig.json'] = 'jsonc',
  },
  pattern = {
    -- Pattern-based detection
    ['tsconfig%.*.json'] = 'jsonc',
    ['%.env%..*'] = 'sh',
  },
})

-- Force treesitter to use correct parsers for React files
vim.treesitter.language.register("tsx", "typescriptreact")
vim.treesitter.language.register("tsx", "javascriptreact") -- Use TSX parser for JSX highlighting


