-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Copilot keymaps (using copilot.lua)
vim.keymap.set("i", "<Tab>", function()
  -- Check if copilot.lua is available before using it
  local ok, copilot_suggestion = pcall(require, "copilot.suggestion")
  if ok and copilot_suggestion.is_visible() then
    copilot_suggestion.accept()
  else
    return "<Tab>"
  end
end, {
  expr = true,
  replace_keycodes = false,
  desc = "Copilot Accept or Tab",
})

vim.keymap.set("i", "<C-J>", function()
  -- Check if copilot.lua is available before using it
  local ok, copilot_suggestion = pcall(require, "copilot.suggestion")
  if ok and copilot_suggestion.is_visible() then
    copilot_suggestion.accept()
  end
end, {
  desc = "Copilot Accept",
})

-- Copilot Chat keymaps
vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<cr>", { desc = "Open Copilot Chat" })
vim.keymap.set("v", "<leader>cc", ":CopilotChatVisual<cr>", { desc = "Open Copilot Chat with selection" })
vim.keymap.set("n", "<leader>ce", "<cmd>CopilotChatExplain<cr>", { desc = "Copilot Explain" })
vim.keymap.set("n", "<leader>cr", "<cmd>CopilotChatReview<cr>", { desc = "Copilot Review" })
vim.keymap.set("n", "<leader>cf", "<cmd>CopilotChatFix<cr>", { desc = "Copilot Fix" })
vim.keymap.set("n", "<leader>co", "<cmd>CopilotChatOptimize<cr>", { desc = "Copilot Optimize" })
