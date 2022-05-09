return function()
	require("mini.comment").setup()
	require("mini.cursorword").setup()
	require("mini.indentscope").setup({
		draw = {
			animation = require("mini.indentscope").gen_animation("cubicInOut", {
				duration = 300,
				unit = "total",
			}),
		},
	})
	require("mini.surround").setup()
end
