return function(config)
	local cmp_ok, cmp = pcall(require, "cmp")
	local luasnip_ok, luasnip = pcall(require, "luasnip")

	if cmp_ok and luasnip_ok then
		config.mapping["<CR>"] = cmp.mapping.confirm()

		config.sources = {
			{ name = "luasnip" },
			{ name = "nvim_lsp" },
			{ name = "pandoc_references" },
			{ name = "path" },
			{ name = "calc" },
			{ name = "emoji" },
			{ name = "latex_symbols" },
			{ name = "buffer" },
			-- { name = "cmp_tabnine" },
		}

		return config
	end
end
