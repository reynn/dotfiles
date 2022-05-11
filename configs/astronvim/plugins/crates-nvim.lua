return function()
	require("crates").setup({
		null_ls = {
			enabled = true,
			name = "crates.nvim",
		},
	})

	require("core.utils").add_cmp_source({
		name = "crates",
		priority = 1000,
		keyword_length = 2,
	})
end
