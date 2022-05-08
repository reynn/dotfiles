return function()
	require("mini.comment").setup()
	require("mini.cursorword").setup()
	require("mini.indentscope").setup({
		draw = {
			animation = require("mini.indentscope").gen_animation("cubicInOut", { duration = 500, unit = "total" }),
			-- animation = require("mini.indentscope").gen_animation(
			-- 	"exponentialInOut",
			-- 	{ duration = 1000, unit = "step" }
			-- ),
		},
	})
	require("mini.surround").setup()
end
