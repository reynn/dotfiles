-- ## Telescope keymaps
local builtin = require('telescope.builtin')
require("which-key").register(
  {
    f = {
      name = "Telescope", -- optional group name
      b = {
        builtin.buffers,
        "Buffers",
      },
      f = {
        builtin.find_files,
        "Find File",
      }, -- create a binding with label
      g = {
        builtin.live_grep,
        "Find Words"
      },
      h = {
        builtin.help_tags,
        "Help Tags"
      },
      r = {
        builtin.old_files,
        -- "<cmd>Telescope oldfiles<cr>",
        "Open Recent File",
      }, -- additional options for creating the keymap
    },
  },
  {
    prefix = "<leader>",
  }
)
