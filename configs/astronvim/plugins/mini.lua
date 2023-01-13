return {
	{
		"echasnovski/mini.nvim",
		lazy = false,
		config = function(_, _)
			local indent_scope = require("mini.indentscope")
			local surround = require("mini.surround")
			local bufremove = require("mini.bufremove")
			local comment = require("mini.comment")
			local cursor_word = require("mini.cursorword")

			bufremove.setup({})
			comment.setup({})
			cursor_word.setup({})
			indent_scope.setup({
				draw = {
					delay = 0,
					animation = indent_scope.gen_animation.cubic({
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
			surround.setup({
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
