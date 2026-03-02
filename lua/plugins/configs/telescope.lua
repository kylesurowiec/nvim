local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
  defaults = {
    path_display = { "truncate" },
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
      },
    },
  },
})

telescope.load_extension("fzf")

-- Additional telescope keymaps (main ones are in core/keymaps.lua)
local keymap = vim.keymap.set

keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
keymap("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find String Under Cursor" })
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
keymap("n", "<leader>ft", "<cmd>Telescope colorscheme<cr>", { desc = "Colorschemes" })