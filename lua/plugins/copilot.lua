return {
  "github/copilot.vim",
  event = "InsertEnter",  -- Lazy load only when you start typing
  config = function()
    -- Optional: tweak suggestion behavior
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true

    -- Optional: custom keymap for accepting suggestion
    vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', {
      expr = true,
      silent = true,
      noremap = true
    })
  end,
}
