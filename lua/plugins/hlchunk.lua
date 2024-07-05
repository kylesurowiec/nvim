return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
<<<<<<< HEAD
    enabled = false,
=======
>>>>>>> e82f656 (fix config)
    config = function()
      require("hlchunk").setup({
        chunk = {
          style = "#00FFFF",
          chars = {
            horizontal_line = "─",
            vertical_line = "│",
            left_top = "┌",
            left_bottom = "└",
            right_arrow = "─",
          },
        },
      })
    end,
  },
}
