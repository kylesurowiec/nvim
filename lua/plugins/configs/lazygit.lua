-- LazyGit configuration
local keymap = vim.keymap.set

-- Main LazyGit keymap
keymap("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })

-- Additional git-related keymaps
keymap("n", "<leader>gf", "<cmd>LazyGitFilter<cr>", { desc = "LazyGit Filter" })
keymap("n", "<leader>gc", "<cmd>LazyGitConfig<cr>", { desc = "LazyGit Config" })