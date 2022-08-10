local cmp_ok, _ = pcall(require, "cmp")
local lspkind_ok, lspkind = pcall(require, "lspkind")
if not cmp_ok then
	return
end

local config = {
	experimental = {
		ghost_text = true,
	},
	view = {
		entries = { name = "custom", selection_order = "near_cursor" },
	},
	window = {
		documentation = {
			border = { " ", " ", " ", " ", " ", " ", " ", " " },
		},
	},
}

if lspkind_ok then
	config.formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			max_width = 75,
		}),
	}
end

return config
