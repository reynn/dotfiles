return {
	astronvim.plugin({
		"junegunn/vim-easy-align",
		lazy = false,
		config = function(_, _)
			return {
				mappings = {
					n = {
						["ga"] = { "<Plug>(EasyAlign)", silent = true },
					},
					x = {
						["ga"] = { "<Plug>(EasyAlign)", silent = true },
					},
				},
			}
		end,
	}),
}
