return {
  {
    "yetone/avante.nvim",
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false,
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = "claude",
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-3-5-sonnet-20241022",
          timeout = 30000,
          extra_request_body = {
            temperature = 0.75,
            max_tokens = 4096,
          },
        },
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o",
          timeout = 30000,
          extra_request_body = {
            temperature = 0,
            max_tokens = 4096,
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      --- file_selector provider telescope
      "nvim-telescope/telescope.nvim",
      -- autocompletion for avante commands and mentions
      "hrsh7th/nvim-cmp",
      -- or echasnovski/mini.icons
      "nvim-tree/nvim-web-devicons",
      {
        -- image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    -- Optional lightweight keymaps. Prefer stable user commands to avoid API breakage.
    keys = function()
      local mappings = {}
      local function nmap(lhs, rhs, desc)
        table.insert(mappings, { lhs, rhs, desc = desc, mode = "n" })
      end

      nmap("<leader>aa", "<cmd>AvanteToggle<cr>", "Avante: Toggle Chat")
      nmap("<leader>ae", "<cmd>AvanteEdit<cr>", "Avante: Edit with AI")

      return mappings
    end,
  },
}
