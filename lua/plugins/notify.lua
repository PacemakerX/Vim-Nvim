return {
  "rcarriga/nvim-notify",
  event = "VeryLazy",
  config = function()
    local notify = require("notify")

    vim.notify = notify

    notify.setup({
      -- Animation style
      stages = "fade_in_slide_out", -- smoother and cleaner
      timeout = 2000,               -- faster disappearance
      render = "default",           -- clean popup
      background_colour = "#1e1e2e", -- subtle dark, matches most dark themes
      minimum_width = 40,
      top_down = true,              -- stack from top to bottom
      fps = 60,                     -- smoother animation
      icons = {
        ERROR = "",  -- nf-fa-times_circle
        WARN  = "",  -- nf-fa-exclamation_triangle
        INFO  = "",  -- nf-fa-info_circle
        DEBUG = "",  -- nf-fa-bug
        TRACE = "✎",  -- playful trace icon
      },
    })
  end,
}
