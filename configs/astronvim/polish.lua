local utils = require("user.utils")

return function()
	utils.augroup("mini", {
		{
			event = { "FileType", "BufEnter" },
			description = "Disable indent scope for content types",
			command = function()
				if
					vim.tbl_contains({
						"NvimTree",
						"TelescopePrompt",
						"Trouble",
						"alpha",
						"help",
						"lsp-installer",
						"lspinfo",
						"neo-tree",
						"neogitstatus",
						"packer",
						"startify",
					}, vim.bo.filetype) or vim.tbl_contains({ "nofile", "terminal" }, vim.bo.buftype)
				then
					vim.b.miniindentscope_disable = true
				end
			end,
		},
	})
	vim.keymap.del("n", "<leader>c")

	if require("astronvim.utils").is_available("bufdelete.nvim") then
		vim.keymap.set("n", "<leader>c", function()
			utils.alpha_on_bye("Bdelete!")
		end, { desc = "Close buffer" })
	else
		vim.keymap.set("n", "<leader>c", function()
			utils.alpha_on_bye("bdelete!")
		end, { desc = "Close buffer" })
	end
end
