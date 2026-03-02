-- Core Neovim initialization
-- This file sets up environment variables and paths before plugins load

-- Fix npm/node PATH for Mason
-- NVM lazy loading can cause issues when Mason spawns npm processes
local function setup_node_path()
  -- Get the current NVM node path
  local nvm_node_path = os.getenv("HOME") .. "/.nvm/versions/node/v22.14.0/bin"
  local current_path = vim.env.PATH or ""
  
  -- Check if the NVM path is already in PATH
  if not string.find(current_path, nvm_node_path, 1, true) then
    vim.env.PATH = nvm_node_path .. ":" .. current_path
  end
end

-- Initialize node path
setup_node_path()