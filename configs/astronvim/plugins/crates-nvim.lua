return function()
	require("crates").setup({
		null_ls = {
			enabled = true,
			name = "crates.nvim",
		},
	})

	require("core.utils").add_cmp_source("crates", 1000)
end
