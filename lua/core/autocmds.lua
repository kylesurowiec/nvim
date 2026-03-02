local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight on yank
autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end,
})

-- Remove trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("remove_trailing_whitespace", { clear = true }),
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  group = augroup("resize_splits", { clear = true }),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Close certain filetypes with 'q'
autocmd("FileType", {
  group = augroup("close_with_q", { clear = true }),
  pattern = {
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
})

-- Disable line wrapping in terminal buffers
autocmd("TermOpen", {
  group = augroup("terminal_nowrap", { clear = true }),
  pattern = "*",
  callback = function()
    vim.wo.wrap = false
  end,
})

-- Check if we need to reload the file when it changed
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime", { clear = true }),
  command = "checktime",
})

-- Ensure diagnostic virtual_text is always enabled
autocmd("VimEnter", {
  group = augroup("diagnostic_config", { clear = true }),
  callback = function()
    vim.diagnostic.config({
      virtual_text = {
        prefix = '●',
        source = "if_many",
        format = function(diagnostic)
          return diagnostic.message
        end,
      },
    })
  end,
})

-- Set cursor colors after colorscheme loads
autocmd("ColorScheme", {
  group = augroup("cursor_colors", { clear = true }),
  callback = function()
    -- Set visual mode cursor to a different color (purple/magenta)
    vim.api.nvim_set_hl(0, "Cursor", { fg = "#16161e", bg = "#dcd7ba" })      -- Normal cursor (foreground/background from kanagawa)
    vim.api.nvim_set_hl(0, "lCursor", { fg = "#16161e", bg = "#dcd7ba" })     -- Language mapping cursor
    vim.api.nvim_set_hl(0, "TermCursor", { fg = "#16161e", bg = "#dcd7ba" })  -- Terminal cursor
    vim.api.nvim_set_hl(0, "TermCursorNC", { fg = "#16161e", bg = "#727169" }) -- Terminal cursor non-current
  end,
})

-- Apply cursor colors on startup
autocmd("VimEnter", {
  group = augroup("cursor_colors_init", { clear = true }),
  callback = function()
    -- Apply the same cursor colors on startup
    vim.api.nvim_set_hl(0, "Cursor", { fg = "#16161e", bg = "#dcd7ba" })
    vim.api.nvim_set_hl(0, "lCursor", { fg = "#16161e", bg = "#dcd7ba" })
    vim.api.nvim_set_hl(0, "TermCursor", { fg = "#16161e", bg = "#dcd7ba" })
    vim.api.nvim_set_hl(0, "TermCursorNC", { fg = "#16161e", bg = "#727169" })
    
    -- Set visual mode cursor to purple/magenta for distinction
    vim.api.nvim_set_hl(0, "Visual", { bg = "#957fb8", fg = "#16161e" })
  end,
})