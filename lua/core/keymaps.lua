-- Set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

-- General keymaps
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
keymap("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights on Esc" })

-- Increment/decrement numbers
keymap("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window management
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Tab management
keymap("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Buffer navigation
keymap("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- Move text up and down
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Stay in indent mode
keymap("v", "<", "<gv", { desc = "Indent left" })
keymap("v", ">", ">gv", { desc = "Indent right" })

-- Better paste
keymap("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Resize windows with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", { desc = "Resize window up" })
keymap("n", "<C-Down>", ":resize -2<CR>", { desc = "Resize window down" })
keymap("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize window left" })
keymap("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize window right" })

-- LazyVim-style additional keymaps
-- Quick access
keymap("n", "<leader><space>", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
keymap("n", "<leader>/", "<cmd>Telescope live_grep<cr>", { desc = "Grep (Root Dir)" })
keymap("n", "<leader>,", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })

-- Buffer management
keymap("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
keymap("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Current Buffer" })

-- Window splits (LazyVim style)
keymap("n", "<leader>-", "<C-w>s", { desc = "Split Window Below" })
keymap("n", "<leader>|", "<C-w>v", { desc = "Split Window Right" })
keymap("n", "<leader>wd", "<C-w>c", { desc = "Delete Window" })

-- Git keymaps (will work when gitsigns is loaded)
keymap("n", "<leader>gs", "<cmd>Telescope git_status<cr>", { desc = "Git Status" })
keymap("n", "<leader>gb", function() require("gitsigns").blame_line({ full = true }) end, { desc = "Git Blame Line" })

-- Diagnostics navigation
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
-- Trouble keymaps are set in the plugin config with backdrop effect

-- LSP (these will be overridden in lspconfig.lua for buffers with LSP)
keymap("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { desc = "Goto Definition" })
keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
keymap("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { desc = "Goto Implementation" })

-- Search keymaps
keymap("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "Show Keymaps" })
keymap("n", "<leader>sg", "<cmd>Telescope live_grep<cr>", { desc = "Grep (Root Dir)" })

-- Quit/Session keymaps
keymap("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit Neovim" })
keymap("n", "<leader>qs", "<cmd>Telescope oldfiles<cr>", { desc = "Quick open Session files (recent)" })

-- Suppress keyboard macro sequences
keymap({'n', 'i', 'v'}, '<S-F8>', '<Nop>', { silent = true })
keymap({'n', 'i', 'v'}, '<S-F9>', '<Nop>', { silent = true })

