local unmap = vim.keymap.del
-- local is_available = require("core.utils").is_available

-- remove default bindings
unmap("n", "<C-Down>")
unmap("n", "<C-Left>")
unmap("n", "<C-Right>")
unmap("n", "<C-Up>")
unmap("n", "<C-q>")
unmap("n", "<C-s>")
unmap("t", "jk")
if astronvim.is_available("nvim-toggleterm.lua") then
	unmap("n", "<C-\\>")
end
if astronvim.is_available("telescope.nvim") then
	unmap("n", "<leader>fh")
	unmap("n", "<leader>fm")
	unmap("n", "<leader>fn")
	unmap("n", "<leader>fo")
	unmap("n", "<leader>sb")
	unmap("n", "<leader>sc")
	unmap("n", "<leader>sh")
	unmap("n", "<leader>sk")
	unmap("n", "<leader>sm")
	unmap("n", "<leader>sn")
	unmap("n", "<leader>sr")
end
