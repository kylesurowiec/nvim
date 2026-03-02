local opt = vim.opt

-- General settings
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = "yes"

-- Tabs and indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.showmode = false
opt.conceallevel = 0

-- Backups and undo
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undodir"

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Cursor configuration
opt.guicursor = {
  "n-v-c:block",              -- Normal, visual, command-line: block cursor
  "i-ci-ve:block-blinkwait700-blinkoff400-blinkon250",  -- Insert, command-line insert, visual exclusive: blinking block
  "r-cr:hor20",               -- Replace, command-line replace: horizontal bar
  "o:hor50",                  -- Operator-pending: horizontal bar
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor", -- All modes: blinking settings
  "sm:block-blinkwait175-blinkoff150-blinkon175",        -- Show match: blinking block
}

-- Other
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.fileencoding = "utf-8"
opt.updatetime = 250
opt.timeoutlen = 1000