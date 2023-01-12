return {
	n = {
		-- -- keep search terms centered on screen
		["n"] = { "nzzzv" },
		["N"] = { "Nzzzv" },
		-- -- Join lines but leave cursor where it is
		["J"] = { "mzJ`z" },
		-- -- easy splits
		["\\"] = { "<cmd>split<cr>", desc = "Horizontal split" },
		["|"] = { "<cmd>vsplit<cr>", desc = "Vertical split" },
	},
	v = {
		-- -- move highlighted lines up or down
		["J"] = { ":m '>+1<CR>gv=gv" },
		["K"] = { ":m '<-2<CR>gv=gv" },
	},
	x = {
		-- -- deletes the highlighted text without overwriting current paste buffer
		["<leader>p"] = { "_dP" },
	},
}
-- -- resize with arrows
-- map("n", "<Up>", function()
-- 	require("smart-splits").resize_up(2)
-- end, { desc = "Resize split up" })
-- map("n", "<Down>", function()
-- 	require("smart-splits").resize_down(2)
-- end, { desc = "Resize split down" })
-- map("n", "<Left>", function()
-- 	require("smart-splits").resize_left(2)
-- end, { desc = "Resize split left" })
-- map("n", "<Right>", function()
-- 	require("smart-splits").resize_right(2)
-- end, { desc = "Resize split right" })
--
