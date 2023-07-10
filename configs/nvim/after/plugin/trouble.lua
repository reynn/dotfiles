-- vim.keymap.set("n", "<leader>xq", ,
--   {silent = true, noremap = true}
-- )
require("which-key").register({
  x = {
    name = "Trouble",
    q = {
      "<cmd>TroubleToggle quickfix<cr>",
      "Trouble quickfix",
    }
  }
}, { prefix = "<leader>" })
