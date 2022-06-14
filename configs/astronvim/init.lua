return {
	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			luasnip = 650,
			buffer = 550,
			path = 500,
		},
	},
	colorscheme = "kanagawa",
	diagnostics = {
		virtual_text = true,
		underline = true,
	},
	polish = function()
		require("user.custom.autocmds")
		require("user.custom.mappings")
		local user_utils = require("user.utils")

		if require("core.utils").is_available("bufdelete.nvim") then
			vim.keymap.set("n", "<leader>c", function()
				user_utils.alpha_on_bye("Bdelete!")
			end, { desc = "Close buffer" })
		else
			vim.keymap.set("n", "<leader>c", function()
				user_utils.alpha_on_bye("bdelete!")
			end, { desc = "Close buffer" })
		end
	end,
	ui = {
		nui_input = true,
		telescope_select = true,
	},
	updater = {
		channel = "nightly",
		skip_prompts = true,
		show_changelog = true,
	},
}
