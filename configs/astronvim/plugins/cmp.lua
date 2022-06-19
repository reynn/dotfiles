local cmp_ok, cmp = pcall(require, "cmp")
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
	-- mapping = {
	-- 	["<CR>"] = cmp.mapping.confirm(),
	-- 	["<Tab>"] = cmp.mapping(function(fallback)
	-- 		if cmp.visible() then
	-- 			cmp.select_next_item()
	-- 		else
	-- 			fallback()
	-- 		end
	-- 	end, {
	-- 		"i",
	-- 		"s",
	-- 	}),
	-- 	["<S-Tab>"] = cmp.mapping(function(fallback)
	-- 		if cmp.visible() then
	-- 			cmp.select_prev_item()
	-- 		else
	-- 			fallback()
	-- 		end
	-- 	end, {
	-- 		"i",
	-- 		"s",
	-- 	}),
	-- },
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
