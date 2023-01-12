local utils = require("user.utils")

return function()
	require("user.autocmds")

	vim.keymap.del("n", "<leader>c")
	if require("core.utils").is_available("bufdelete.nvim") then
		vim.keymap.set("n", "<leader>c", function()
			utils.alpha_on_bye("Bdelete!")
		end, { desc = "Close buffer" })
	else
		vim.keymap.set("n", "<leader>c", function()
			utils.alpha_on_bye("bdelete!")
		end, { desc = "Close buffer" })
	end
end
