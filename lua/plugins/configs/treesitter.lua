local configs = require("nvim-treesitter.configs")

-- Safer configuration with error handling
local config = {
  highlight = {
    enable = true,
    -- Disable highlighting for large files to improve performance
    disable = function(lang, buf)
      local max_filesize = 100 * 1024 -- 100 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
    -- Force enable additional highlighting
    additional_vim_regex_highlighting = false,
  },
  indent = { 
    enable = true,
    -- Disable indent for problematic filetypes
    disable = { "python", "yaml" },
  },
  ensure_installed = {
    "json",
    "jsonc", -- Add JSON with comments support
    "javascript",
    "typescript",
    "tsx", -- TypeScript JSX (handles both TSX and JSX)
    "yaml",
    "html",
    "css",
    "scss", -- Add SCSS support
    "prisma",
    "markdown",
    "markdown_inline",
    "bash",
    "lua",
    "vim",
    "vimdoc", -- Add Vim documentation
    "dockerfile",
    "gitignore",
    "gitcommit", -- Add git commit support
    "python",
    "go",
    "rust",
    "c",
    "cpp",
    "c_sharp",
    "zig", -- Add Zig support
    "sql", -- Add SQL support
    "regex", -- Add regex highlighting
    "jsdoc", -- Add JSDoc support for better React documentation
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
}

-- Only add textobjects if the plugin is available
local textobjects_ok, _ = pcall(require, "nvim-treesitter.textobjects")
if textobjects_ok then
  config.textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
      },
    },
  }
end

configs.setup(config)