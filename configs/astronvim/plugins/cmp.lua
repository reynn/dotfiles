local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")

-- local source_mapping = {
-- 	-- if you change or add symbol here
-- 	-- replace corresponding line in readme
-- 	Text = "",
-- 	Method = "",
-- 	Function = "",
-- 	Constructor = "",
-- 	Field = "ﰠ",
-- 	Variable = "",
-- 	Class = "ﴯ",
-- 	Interface = "",
-- 	Module = "",
-- 	Property = "ﰠ",
-- 	Unit = "塞",
-- 	Value = "",
-- 	Enum = "",
-- 	Keyword = "",
-- 	Snippet = "",
-- 	Color = "",
-- 	File = "",
-- 	Reference = "",
-- 	Folder = "",
-- 	EnumMember = "",
-- 	Constant = "",
-- 	Struct = "פּ",
-- 	Event = "",
-- 	Operator = "",
-- 	TypeParameter = "",
-- }

return {
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			max_width = 75,
			-- before = function(entry, vim_item)
			-- 	vim_item.kind = lspkind.presets.default[vim_item.kind]
			--
			-- 	local menu = source_mapping[entry.source.name]
			-- 	if entry.source.name == "cmp_tabnine" then
			-- 		if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
			-- 			menu = entry.completion_item.data.detail .. " " .. menu
			-- 		end
			-- 		vim_item.kind = ""
			-- 	end
			--
			-- 	vim_item.menu = menu
			--
			-- 	return vim_item
			-- end,
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
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
}
