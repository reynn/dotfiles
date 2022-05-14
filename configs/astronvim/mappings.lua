local unmap = vim.keymap.del
local is_available = require("core.utils").is_available

-- remove default bindings
unmap("n", "<C-Down>")
unmap("n", "<C-Left>")
unmap("n", "<C-Right>")
unmap("n", "<C-Up>")
unmap("n", "<C-q>")
unmap("n", "<C-s>")
unmap("v", "<")
unmap("v", ">")
unmap("t", "<esc>")
unmap("t", "jk")
unmap("n", "<leader>h")
if is_available("nvim-toggleterm.lua") then
	unmap("n", "<C-\\>")
end
if is_available("telescope.nvim") then
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
