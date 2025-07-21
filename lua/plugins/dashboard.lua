return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("dashboard").setup({
      theme = "hyper",
      config = {
        header = {
          "🧠  Welcome, Sparsh!",
          "🚀  Ready to code like a beast?",
        },
        shortcut = {
          { desc = "  Files", action = "Telescope find_files", key = "f" },
          { desc = "  Projects", action = "Telescope projects", key = "p" },
        },
      }
    })
  end,
}
