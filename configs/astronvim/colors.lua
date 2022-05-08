return {
	theme = "catppuccin",
	catppuccin = function()
		print("Configuring catppuccin theme")
		require("catppuccin").setup({
			integrations = {
				ts_rainbow = true,
				lsp_trouble = true,
			},
		})

		require("lualine").setup({
			options = {
				theme = "catppuccin",
			},
		})
	end,
	["gruvbox-flat"] = function()
		-- vim.g.gruvbox_flat_style = "dark"
		vim.g.gruvbox_sidebars = { "qf", "vista_kind", "terminal", "packer" }
		vim.g.gruvbox_italic_functions = true

		require("lualine").setup({
			options = {
				theme = "gruvbox-flat",
			},
		})
	end,
	["gruvbox-material"] = function()
		vim.g.gruvbox_material_background = "hard"
		vim.g.gruvbox_material_better_performance = 1
	end,
	["gruvbox-baby"] = function()
		vim.g.gruvbox_baby_telescope_theme = 1
		-- vim.g.gruvbox_baby_transparent_mode = 1
		vim.g.gruvbox_baby_background_color = "dark"

		vim.g.gruvbox_baby_comment_style = "NONE"
		vim.g.gruvbox_baby_function_style = "NONE"
		vim.g.gruvbox_baby_keyword_style = "standout"
		vim.g.gruvbox_baby_variable_style = "NONE"

		require("lualine").setup({
			options = {
				theme = "gruvbox-baby",
			},
		})
	end,
	tokyodark = function()
		vim.g.tokyodark_enable_italic_comment = true
		vim.g.tokyodark_enable_italic = true
		vim.g.tokyodark_transparent_background = true
	end,
	material = function()
		require("material").setup({
			lualine_style = "stealth",
		})
		vim.g.material_style = "darker"

		require("lualine").setup({
			options = {
				theme = "material",
			},
		})
	end,
}
