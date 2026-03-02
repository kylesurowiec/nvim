return {
  -- Telescope fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "master", -- Use master branch for latest fixes
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("plugins.configs.telescope")
    end,
  },

  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("plugins.configs.treesitter")
    end,
  },

  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("plugins.configs.catppuccin")
    end,
  },

  -- Mason (LSP installer)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry", -- For roslyn
        },
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
        -- Environment and PATH configuration for npm/node tools
        install_root_dir = vim.fn.stdpath("data") .. "/mason",
        PATH = "prepend", -- Prepend Mason bin to PATH
      })
    end,
  },

  -- Mason LSP config (minimal setup to avoid enable() error)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      -- Central mason-lspconfig setup
      require("mason-lspconfig").setup({
        ensure_installed = {
          "ts_ls",
          "html",
          "cssls",
          "tailwindcss",
          "lua_ls",
          "pyright",
          "rust_analyzer",
          "eslint",
          "clangd", -- Added clangd here
          "zls",    -- Zig Language Server
        },
        automatic_installation = true,
        -- No handlers - let lspconfig.lua handle the configuration
        handlers = {},
      })
    end,
  },

  -- Mason tool installer
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier",
          "eslint_d",
          "clang-format",
          -- Note: zigfmt is built into zig, no need to install separately
        },
        auto_update = false,
        run_on_start = true,
      })
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      require("plugins.configs.lspconfig")
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("plugins.configs.nvim-cmp")
    end,
  },

  -- File explorer
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.configs.oil")
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.configs.lualine")
    end,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.configs.gitsigns")
    end,
  },

  -- LazyGit integration
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("plugins.configs.lazygit")
    end,
  },

  -- Which-key (keymap hints)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("plugins.configs.which-key")
    end,
  },

  -- Bufferline (buffer tabs)
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.configs.bufferline")
    end,
  },

  -- Mini.nvim collection
  {
    "echasnovski/mini.nvim",
    config = function()
      require("plugins.configs.mini")
    end,
  },

  -- Code formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    config = function()
      require("plugins.configs.conform")
    end,
  },

  -- Roslyn LSP for C#
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {
      -- Default options are fine for most use cases
    },
  },


  -- Terminal popup
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "float",
        float_opts = {
          border = "rounded",
          width = function() return math.floor(vim.o.columns * 0.8) end,
          height = function() return math.floor(vim.o.lines * 0.8) end,
          winblend = 15,
        },
        start_in_insert = true,
        insert_mappings = false,  -- keep off if you don't want it in insert mode
        terminal_mappings = true, -- <-- REQUIRED for the key to work inside the terminal
        open_mapping = [[<C-_>]], -- Ctrl+/
      })
    end,
  },

  -- No Neck Pain (centering with left padding only)
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    config = function()
      require("no-neck-pain").setup({
        buffers = {
          right = {
            enabled = false
          }
        }
      })

      -- Auto-enable NoNeckPain when Neovim starts
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          vim.cmd("NoNeckPain")
        end,
      })
    end,
  },

  -- Dressing (better vim.ui interfaces)
  {
    "stevearc/dressing.nvim",
    opts = {
      input = {
        enabled = true,
        default_prompt = "Input:",
        title_pos = "center",
        insert_only = true,
        start_in_insert = true,
        border = "rounded",
        relative = "editor",
        prefer_width = 40,
        width = nil,
        max_width = { 140, 0.9 },
        min_width = { 20, 0.2 },
        buf_options = {},
        win_options = {
          wrap = false,
          list = true,
          listchars = "precedes:…,extends:…",
          sidescrolloff = 0,
        },
      },
      select = {
        enabled = true,
        backend = { "nui", "telescope", "builtin" },
        trim_prompt = true,
        nui = {
          position = "50%",
          size = {
            width = 80,
            height = 15,
          },
          relative = "editor",
          border = {
            style = "rounded",
            text = {
              top = " Select ",
              top_align = "center",
            },
          },
          buf_options = {
            swapfile = false,
            filetype = "DressingSelect",
          },
          win_options = {
            winblend = 0,
          },
          max_width = 80,
          max_height = 15,
          min_width = 40,
          min_height = 8,
        },
      },
    },
  },

  -- Trouble (better diagnostics, references, quickfix)
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({
        focus = true, -- Focus the window when opened
        win = {
          type = "float",
          relative = "editor",
          border = "rounded",
          title = "Trouble",
          title_pos = "center",
          position = { 0.5, 0.5 },              -- Center position
          size = { width = 0.8, height = 0.8 }, -- 80% of screen
          zindex = 1001,
        },
        -- Auto close when jumping to item
        keys = {
          ["<cr>"] = "jump_close",
          ["o"] = "jump_close",
          ["<esc>"] = "close",
          ["q"] = "close",
        },
      })

      -- Standard trouble keymaps without backdrop
      vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle("diagnostics") end, { desc = "Diagnostics (Trouble)" })
      vim.keymap.set("n", "<leader>xX", function() require("trouble").toggle("diagnostics", { filter = { buf = 0 } }) end,
        { desc = "Buffer Diagnostics (Trouble)" })
      vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("lsp") end,
        { desc = "LSP Definitions / references / ... (Trouble)" })
    end,
  },

  -- Colorizer (color preview for CSS, Tailwind, etc)
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        filetypes = {
          "css",
          "scss",
          "sass",
          "html",
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
          "vue",
          "svelte",
          "astro",
          "lua",
        },
        user_default_options = {
          RGB = true,       -- #RGB hex codes
          RRGGBB = true,    -- #RRGGBB hex codes
          names = false,    -- "Name" codes like Blue
          RRGGBBAA = true,  -- #RRGGBBAA hex codes
          rgb_fn = true,    -- CSS rgb() and rgba() functions
          hsl_fn = true,    -- CSS hsl() and hsla() functions
          css = true,       -- Enable all CSS features
          css_fn = true,    -- Enable all CSS *functions*
          mode = "background", -- Set the display mode: "foreground" | "background" | "virtualtext"
          tailwind = true,  -- Enable tailwind colors
          sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
          virtualtext = "■",
        },
      })
    end,
  },

  -- Markdown rendering
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    ft = "markdown",
    config = function()
      require("plugins.configs.render-markdown")
    end,
  },

  -- Noice (better UI for messages, cmdline, LSP hover)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- Override markdown rendering for proper display
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          lsp_doc_border = true,
        },
      })
    end,
  },

}
