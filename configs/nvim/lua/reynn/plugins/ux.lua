return {
  {
    "theprimeagen/harpoon",
    lazy = true,
    keys = { "<C-e>", "<C-h>", "<C-t>", "<C-n>", "<C-s>" },
    config = function()
      local ui = require("harpoon.ui")
      local marks = require("harpoon.mark")

      vim.keymap.set("n", "<C-e>", ui.toggle_quick_menu, { desc = "Harpoon: Quick Menu" })
      vim.keymap.set("n", "<leader>Ha", marks.add_file, { desc = "Add Mark" })

      vim.keymap.set("n", "<C-h>", function() ui.nav_file(1) end, { desc = "Harpoon: Jump File 1" })
      vim.keymap.set("n", "<C-t>", function() ui.nav_file(2) end, { desc = "Harpoon: Jump File 2" })
      vim.keymap.set("n", "<C-n>", function() ui.nav_file(3) end, { desc = "Harpoon: Jump File 3" })
      vim.keymap.set("n", "<C-s>", function() ui.nav_file(4) end, { desc = "Harpoon: Jump File 4" })

      -- Set up Telescope extras
      require("telescope").load_extension('harpoon')
      vim.keymap.set("n", "<leader>fh", "<cmd>Telescope harpoon marks<cr>", { silent = true, desc = "Harpoon Marks" })

      require("harpoon").setup({
        menu = {
          width = vim.api.nvim_win_get_width(0) - 15,
        }
      })
    end
  },
  {
    "bkad/CamelCaseMotion",
    event = "BufEnter",
    config = function()
      vim.keymap.set("n", "w", "<Plug>CamelCaseMotion_w", { silent = true })
      vim.keymap.set("n", "b", "<Plug>CamelCaseMotion_b", { silent = true })
      vim.keymap.set("n", "e", "<Plug>CamelCaseMotion_e", { silent = true })
      vim.keymap.set("n", "ge", "<Plug>CamelCaseMotion_ge", { silent = true })
    end,
  },
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    config = function()
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {desc = "UndoTree: Toggle"})
    end
  },
  {
    "m-demare/hlargs.nvim",
    event = "BufEnter",
    config = function()
      local hlargs = require('hlargs')
      hlargs.setup({})
      vim.keymap.set("n", "<leader>oh", hlargs.toggle, {desc = "Toggle: hlargs"})
    end
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require('notify').setup({
        timeout = 1000,
        fps = 120,
        render = "simple",
      })
      vim.notify = require("notify")

      require("telescope").load_extension("notify")
      vim.keymap.set("n", "<leader>fn", "<cmd>Telescope notify<cr>", {desc="Notifications"})
    end
  },
  {
    "smjonas/inc-rename.nvim",
    event = "BufEnter",
  },
}
