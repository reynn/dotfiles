local map = vim.keymap.set
local silentOpt = { silent = true }

map("n", "ga", "<Plug>(EasyAlign)", silentOpt)
map("x", "ga", "<Plug>(EasyAlign)", silentOpt)
map("n", "w", "<Plug>CamelCaseMotion_w", silentOpt)
map("n", "b", "<Plug>CamelCaseMotion_b", silentOpt)
map("n", "e", "<Plug>CamelCaseMotion_e", silentOpt)
map("n", "ge", "<Plug>CamelCaseMotion_ge", silentOpt)
map("o", "iw", "<Plug>CamelCaseMotion_iw", silentOpt)
map("x", "iw", "<Plug>CamelCaseMotion_iw", silentOpt)
map("o", "ib", "<Plug>CamelCaseMotion_ib", silentOpt)
map("x", "ib", "<Plug>CamelCaseMotion_ib", silentOpt)
map("o", "ie", "<Plug>CamelCaseMotion_ie", silentOpt)
map("x", "ie", "<Plug>CamelCaseMotion_ie", silentOpt)
map("i", "<S-Left>", "<C-o><Plug>CamelCaseMotion_b", silentOpt)
map("i", "<S-Right>", "<C-o><Plug>CamelCaseMotion_w", silentOpt)

-- Join lines but leave cursor where it is
map("n", "J", "mzJ`z")
-- move highlighted lines up or down
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
-- keep search terms centered on screen
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
-- deletes the highlighted text without overwriting current paste buffer
map("x", "<leader>p", '"_dP')

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
