-- Mini.nvim configuration

-- Mini.comment - Enhanced commenting functionality
require("mini.comment").setup({
  -- Options which control module behavior
  options = {
    -- Function to compute custom 'commentstring' (optional)
    custom_commentstring = nil,
    
    -- Whether to ignore blank lines when commenting
    ignore_blank_line = false,
    
    -- Whether to recognize as comment only lines without indent
    start_of_line = false,
    
    -- Whether to force single space inner padding for comment parts
    pad_comment_parts = true,
  },
  
  -- Module mappings. Use `false` to disable one.
  mappings = {
    -- Toggle comment (like `gcip` - comment inner paragraph) for both
    -- Normal and Visual modes
    comment = 'gc',
    
    -- Toggle comment on current line
    comment_line = 'gcc',
    
    -- Toggle comment on visual selection
    comment_visual = 'gc',
    
    -- Define 'comment' textobject (like `dgc` - delete whole comment block)
    textobject = 'gc',
  },
})

-- Mini.cursorword - Highlight word under cursor
require("mini.cursorword").setup({
  -- Delay (in ms) between when cursor moved and when highlighting appeared
  delay = 100,
})

-- Mini.icons - Icon provider (alternative to nvim-web-devicons)
require("mini.icons").setup({
  -- Icon style: 'glyph' or 'ascii'
  style = 'glyph',
  
  -- Customize icons for different file types, LSP, etc.
  default = {},
  directory = {},
  extension = {},
  file = {},
  filetype = {},
  lsp = {},
  os = {},
})

-- Mini.statusline - Minimal statusline
require("mini.statusline").setup({
  -- Content of statusline as functions which return statusline string. See
  -- `:h statusline` and code of default contents (used instead of `nil`).
  content = {
    -- Content for active window
    active = nil,
    -- Content for inactive window(s)
    inactive = nil,
  },

  -- Whether to use icons (requires 'mini.icons')
  use_icons = true,

  -- Whether to set Vim's settings for statusline (make it always shown with
  -- 'laststatus' set to 2). To use global statusline in Neovim>=0.7.0, set
  -- this to `false` and 'laststatus' to 3.
  set_vim_settings = true,
})

-- Mini.indentscope - Animate and highlight current indent scope
require("mini.indentscope").setup({
  -- Draw options
  draw = {
    -- Delay (in ms) between event and start of drawing scope indicator
    delay = 100,

    -- Animation rule for scope's first drawing. A function which, given
    -- next and total step numbers, returns wait time (in ms). See
    -- |MiniIndentscope.gen_animation| for builtin options. To disable
    -- animation, use `require('mini.indentscope').gen_animation.none()`.
    animation = require('mini.indentscope').gen_animation.exponential({
      easing = 'out',
      duration = 100,
      unit = 'total',
    }),

    -- Symbol priority. Increase to display on top of more symbols.
    priority = 2,
  },

  -- Module mappings. Use `false` to disable one.
  mappings = {
    -- Textobjects
    object_scope = 'ii',
    object_scope_with_border = 'ai',

    -- Motions (jump to respective border line; if not present - body line)
    goto_top = '[i',
    goto_bottom = ']i',
  },

  -- Options which control scope computation
  options = {
    -- Type of scope's border: which line(s) with smaller indent to
    -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
    border = 'both',

    -- Whether to use cursor column when computing reference indent.
    -- Useful to see incremental scopes with large indents or to handle
    -- special cases like object keys in JavaScript.
    indent_at_cursor = true,

    -- Whether to first check input line to be a border of adjacent scope.
    -- Use it if you want to place cursor on function header to get scope of
    -- its body.
    try_as_border = false,
  },

  -- Which character to use for drawing scope indicator
  symbol = '╎',
})

-- Mini.notify - Show notifications
require("mini.notify").setup({
  -- Content management
  content = {
    -- Function which formats the notification message
    format = nil,

    -- Function which orders notification array from most to least important
    sort = nil,
  },

  -- Notifications about LSP progress
  lsp_progress = {
    -- Whether to enable showing
    enable = true,

    -- Duration (in ms) of how long last message should be shown
    duration_last = 1000,
  },

  -- Window management
  window = {
    -- Floating window config
    config = {},

    -- Maximum window width as share (between 0 and 1) of available columns
    max_width_share = 0.382,

    -- Value of 'winblend' option for floating window
    winblend = 25,
  },
})

-- Mini.surround - Add/delete/replace surroundings
require("mini.surround").setup({
  -- Add custom surroundings to be used on top of builtin ones. For more
  -- information with examples, see `:h MiniSurround.config`.
  custom_surroundings = nil,

  -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
  highlight_duration = 500,

  -- Module mappings. Use `false` to disable one.
  mappings = {
    add = 'sa', -- Add surrounding in Normal and Visual modes
    delete = 'sd', -- Delete surrounding
    find = 'sf', -- Find surrounding (to the right)
    find_left = 'sF', -- Find surrounding (to the left)
    highlight = 'sh', -- Highlight surrounding
    replace = 'sr', -- Replace surrounding
    update_n_lines = 'sn', -- Update `n_lines`

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'n', -- Suffix to search with "next" method
  },

  -- Number of lines within which surrounding is searched
  n_lines = 20,

  -- Whether to respect selection type:
  -- - Place surroundings on separate lines in linewise mode.
  -- - Place surroundings on each line in blockwise mode.
  respect_selection_type = false,

  -- How to search for surrounding (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
  -- see `:h MiniSurround.config`.
  search_method = 'cover',

  -- Whether to disable showing non-error feedback
  silent = false,
})