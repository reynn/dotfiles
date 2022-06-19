return {
	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			cmp_tabnine = 800,
			luasnip = 650,
			buffer = 550,
			path = 500,
		},
	},
	colorscheme = "catppuccin",
	diagnostics = {
		virtual_text = true,
		underline = true,
	},
	polish = function()
		require("user.custom.autocmds")
		require("user.custom.mappings")

		if require("core.utils").is_available("bufdelete.nvim") then
			vim.keymap.set("n", "<leader>c", function()
				require("user.utils").alpha_on_bye("Bdelete!")
			end, {
				desc = "Close buffer",
			})
		else
			vim.keymap.set("n", "<leader>c", function()
				require("user.utils").alpha_on_bye("bdelete!")
			end, {
				desc = "Close buffer",
			})
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
