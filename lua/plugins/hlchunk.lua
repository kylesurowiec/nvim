return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "UIEnter" },
    enabled = false,
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
