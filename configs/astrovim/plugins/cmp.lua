return function(config)
	local cmp_ok, cmp = pcall(require, "cmp")
	local luasnip_ok, luasnip = pcall(require, "luasnip")

	if cmp_ok and luasnip_ok then
		config.mapping["<CR>"] = cmp.mapping.confirm()

		config.sources = {
      { name = "crates" },
			{ name = "luasnip" },
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "buffer" },
		}

		return config
	end
end
