-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Cross-platform clipboard integration
local function setup_clipboard()
  -- Detect WSL
  if vim.fn.has("wsl") == 1 or os.getenv("WSL_DISTRO_NAME") or os.getenv("WSLENV") then
    vim.g.clipboard = {
      name = "win32yank-wsl",
      copy = {
        ["+"] = "win32yank.exe -i --crlf",
        ["*"] = "win32yank.exe -i --crlf",
      },
      paste = {
        ["+"] = "win32yank.exe -o --lf",
        ["*"] = "win32yank.exe -o --lf",
      },
    }
  -- macOS
  elseif vim.fn.has("mac") == 1 then
    vim.g.clipboard = {
      name = "pbcopy",
      copy = {
        ["+"] = "pbcopy",
        ["*"] = "pbcopy",
      },
      paste = {
        ["+"] = "pbpaste",
        ["*"] = "pbpaste",
      },
    }
  -- Linux with X11 or Wayland
  elseif vim.fn.has("unix") == 1 then
    if vim.fn.executable("xclip") == 1 then
      vim.g.clipboard = {
        name = "xclip",
        copy = {
          ["+"] = "xclip -selection clipboard",
          ["*"] = "xclip -selection primary",
        },
        paste = {
          ["+"] = "xclip -selection clipboard -o",
          ["*"] = "xclip -selection primary -o",
        },
      }
    elseif vim.fn.executable("xsel") == 1 then
      vim.g.clipboard = {
        name = "xsel",
        copy = {
          ["+"] = "xsel --clipboard --input",
          ["*"] = "xsel --primary --input",
        },
        paste = {
          ["+"] = "xsel --clipboard --output",
          ["*"] = "xsel --primary --output",
        },
      }
    elseif vim.fn.executable("wl-copy") == 1 then
      vim.g.clipboard = {
        name = "wl-clipboard",
        copy = {
          ["+"] = "wl-copy",
          ["*"] = "wl-copy --primary",
        },
        paste = {
          ["+"] = "wl-paste",
          ["*"] = "wl-paste --primary",
        },
      }
    end
  end
end

setup_clipboard()

-- Ensure true color support for themes like cyberdream
vim.opt.termguicolors = true
