-- vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
require('which-key').register(
  {
    u = {
      vim.cmd.UndotreeToggle,
      "UndoTree: Toggle"
    }
  },
  {
    prefix = "<leader>",
  }
)
