-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Copilot keymaps
vim.keymap.set("i", "<Tab>", function()
  if vim.fn.exists("*copilot#Accept") == 1 then
    local suggestion = vim.fn["copilot#Accept"]("")
    if suggestion ~= "" then
      return suggestion
    end
  end
  return "<Tab>"
end, {
  expr = true,
  replace_keycodes = false,
  desc = "Copilot Accept or Tab"
})

vim.keymap.set("i", "<C-J>", 'copilot#Accept("")', {
  expr = true,
  replace_keycodes = false,
  desc = "Copilot Accept"
})

vim.g.copilot_no_tab_map = true

-- Copilot Chat keymaps
vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<cr>", { desc = "Open Copilot Chat" })
vim.keymap.set("v", "<leader>cc", ":CopilotChatVisual<cr>", { desc = "Open Copilot Chat with selection" })
vim.keymap.set("n", "<leader>ce", "<cmd>CopilotChatExplain<cr>", { desc = "Copilot Explain" })
vim.keymap.set("n", "<leader>cr", "<cmd>CopilotChatReview<cr>", { desc = "Copilot Review" })
vim.keymap.set("n", "<leader>cf", "<cmd>CopilotChatFix<cr>", { desc = "Copilot Fix" })
vim.keymap.set("n", "<leader>co", "<cmd>CopilotChatOptimize<cr>", { desc = "Copilot Optimize" })
