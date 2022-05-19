return function()
	require("crates").setup({
		null_ls = {
			enabled = true,
			name = "crates.nvim",
		},
	})

  astronvim.add_cmp_source({
    name = "crates",
    priority = 1000,
    keyword_length = 2,
    max_item_count = 7,
  })
end
