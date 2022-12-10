local map = vim.keymap.set

map("n", "ga", "<Plug>(EasyAlign)", { silent = true })
map("x", "ga", "<Plug>(EasyAlign)", { silent = true })
map("n", "w", "<Plug>CamelCaseMotion_w", { silent = true })
map("n", "b", "<Plug>CamelCaseMotion_b", { silent = true })
map("n", "e", "<Plug>CamelCaseMotion_e", { silent = true })
map("n", "ge", "<Plug>CamelCaseMotion_ge", { silent = true })
map("o", "iw", "<Plug>CamelCaseMotion_iw", { silent = true })
map("x", "iw", "<Plug>CamelCaseMotion_iw", { silent = true })
map("o", "ib", "<Plug>CamelCaseMotion_ib", { silent = true })
map("x", "ib", "<Plug>CamelCaseMotion_ib", { silent = true })
map("o", "ie", "<Plug>CamelCaseMotion_ie", { silent = true })
map("x", "ie", "<Plug>CamelCaseMotion_ie", { silent = true })
map("i", "<S-Left>", "<C-o><Plug>CamelCaseMotion_b", { silent = true })
map("i", "<S-Right>", "<C-o><Plug>CamelCaseMotion_w", { silent = true })

-- resize with arrows
map("n", "<Up>", function()
  require("smart-splits").resize_up(2)
end, { desc = "Resize split up" })
map("n", "<Down>", function()
  require("smart-splits").resize_down(2)
end, { desc = "Resize split down" })
map("n", "<Left>", function()
  require("smart-splits").resize_left(2)
end, { desc = "Resize split left" })
map("n", "<Right>", function()
  require("smart-splits").resize_right(2)
end, { desc = "Resize split right" })

-- easy splits
map("n", "\\", "<cmd>split<cr>", { desc = "Horizontal split" })
map("n", "|", "<cmd>vsplit<cr>", { desc = "Vertical split" })
