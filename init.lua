-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin" .. (false and "; " or ":") .. vim.env.PATH

vim.cmd(":set termguicolors")
vim.cmd(":hi Cursor guifg=orange guibg=orange")
vim.cmd(":hi Cursor2 guifg=teal guibg=teal")
vim.cmd(
  "set guicursor=n-v-c:block-Cursor/lCursor,i-ci-ve:block-Cursor2/lCursor2,r-cr:hor20,o:hor50"
)
