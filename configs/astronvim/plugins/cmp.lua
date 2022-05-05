local cmp = require("cmp")
local neogen = require("neogen")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

return {
	formatting = {
		format = lspkind.cmp_format({
			mode = "text_symbol",
			max_width = 75,
		}),
	},
	mappings = {
		["<tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif neogen.jumpable() then
				neogen.jump_next()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			elseif neogen.jumpable(true) then
				neogen.jump_prev()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
}
