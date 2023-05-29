return {
	{
		"echasnovski/mini.nvim",
		lazy = false,
		config = function(_, _)
			require("mini.bufremove").setup()
			require("mini.comment").setup()
			require("mini.cursorword").setup()
			require("mini.indentscope").setup({
				draw = {
					delay = 0,
					animation = require("mini.indentscope").gen_animation.cubic({
						easing = "in-out",
						duration = 100,
						unit = "total",
					}),
				},
				options = {
					indent_at_cursor = false,
				},
				symbol = "▏",
			})
			require("mini.surround").setup({
				highlight_duration = 2000,
			})

			local disable = {
				"base16",
				"completion",
				"cursorword",
				"doc",
				"fuzzy",
				"misc",
				"pairs",
				"sessions",
				"starter",
				"statusline",
				"tabline",
				"trailspace",
			}
			for _, plugin in ipairs(disable) do
				vim.g["mini" .. plugin .. "_disable"] = true
			end
		end,
	},
}
