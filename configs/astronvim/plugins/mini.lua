return function()
	require("mini.comment").setup()
	require("mini.cursorword").setup()
	require("mini.indentscope").setup({
		draw = {
      delay = 0,
			animation = require("mini.indentscope").gen_animation("cubicInOut", {
				duration = 150,
				unit = "total",
			}),
		},
		options = {
			indent_at_cursor = false,
		},
		symbol = "▏",
	})
	require("mini.surround").setup()

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
end
