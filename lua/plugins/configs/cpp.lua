-- C++ specific configurations and keymaps

local keymap = vim.keymap.set

-- Create C++ specific autocommands
local cpp_augroup = vim.api.nvim_create_augroup("CppConfig", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = cpp_augroup,
  pattern = { "c", "cpp", "objc", "objcpp" },
  callback = function()
    local opts = { noremap = true, silent = true, buffer = true }
    
    -- C++ specific keymaps
    keymap("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", 
           vim.tbl_extend("force", opts, { desc = "Switch between source/header" }))
    keymap("n", "<leader>ct", "<cmd>ClangdTypeHierarchy<cr>", 
           vim.tbl_extend("force", opts, { desc = "Show type hierarchy" }))
    keymap("n", "<leader>cs", "<cmd>ClangdSymbolInfo<cr>", 
           vim.tbl_extend("force", opts, { desc = "Symbol info" }))
    
    -- Buffer local settings
    vim.opt_local.commentstring = "// %s"
    vim.opt_local.cindent = true
    vim.opt_local.cinoptions = ":0,l1,t0,g0,(0"
    
    -- Enhanced syntax highlighting for modern C++
    vim.cmd([[
      syntax keyword cppSTLtype string vector map set list deque queue stack
      syntax keyword cppSTLtype shared_ptr unique_ptr weak_ptr
      syntax keyword cppSTLtype optional variant any
      syntax keyword cppSTLtype thread mutex condition_variable
      syntax keyword cppSTLtype chrono duration time_point
      hi def link cppSTLtype Type
    ]])
  end,
})

-- Clangd specific commands and settings
vim.api.nvim_create_user_command("ClangdRestart", function()
  vim.cmd("LspRestart clangd")
end, { desc = "Restart clangd language server" })

vim.api.nvim_create_user_command("ClangdInfo", function()
  vim.cmd("LspInfo")
end, { desc = "Show clangd information" })

-- Enhanced diagnostics for C++
vim.api.nvim_create_autocmd("LspAttach", {
  group = cpp_augroup,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client.name == "clangd" then
      -- Set up clangd specific keymaps
      local opts = { noremap = true, silent = true, buffer = ev.buf }
      keymap("n", "<leader>co", "<cmd>lua vim.lsp.buf.outgoing_calls()<cr>", 
             vim.tbl_extend("force", opts, { desc = "Outgoing calls" }))
      keymap("n", "<leader>ci", "<cmd>lua vim.lsp.buf.incoming_calls()<cr>", 
             vim.tbl_extend("force", opts, { desc = "Incoming calls" }))
    end
  end,
})

-- Compile commands generation helper
vim.api.nvim_create_user_command("GenerateCompileCommands", function()
  local cwd = vim.fn.getcwd()
  local build_dir = cwd .. "/build"
  
  -- Check if we're in a cmake project
  if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
    vim.notify("Generating compile_commands.json for CMake project...")
    
    -- First check if dependencies are installed
    local libobs_check = vim.fn.system("pkg-config --exists libobs 2>/dev/null && echo 'found' || echo 'missing'"):gsub("%s+", "")
    
    if libobs_check == "missing" then
      vim.notify("OBS dependencies not installed. Run: ./scripts/install-deps.sh", vim.log.levels.WARN)
      
      -- Create basic compile_commands.json for clangd to work
      local basic_compile_commands = string.format([[
[
  {
    "directory": "%s",
    "command": "clang++ -std=c++17 -I/usr/include/obs -I/usr/include -DLINUX -c src/replay_ding.cpp",
    "file": "src/replay_ding.cpp"
  }
]
]], cwd)
      
      local file = io.open(cwd .. "/compile_commands.json", "w")
      if file then
        file:write(basic_compile_commands)
        file:close()
        vim.notify("Created basic compile_commands.json for clangd (install deps for full support)")
      end
      return
    end
    
    -- Generate with CMake if dependencies are available
    local result = vim.fn.system("cmake -B " .. build_dir .. " -DCMAKE_EXPORT_COMPILE_COMMANDS=1 2>&1")
    
    -- Link compile_commands.json to root for clangd
    local compile_commands = build_dir .. "/compile_commands.json"
    if vim.fn.filereadable(compile_commands) == 1 then
      vim.fn.system("ln -sf " .. compile_commands .. " " .. cwd .. "/")
      vim.notify("compile_commands.json linked to project root")
    else
      vim.notify("Failed to generate compile_commands.json: " .. result, vim.log.levels.ERROR)
    end
  else
    vim.notify("No CMakeLists.txt found in current directory", vim.log.levels.WARN)
  end
end, { desc = "Generate compile_commands.json for clangd" })