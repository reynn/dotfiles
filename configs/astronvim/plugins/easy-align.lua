return {
	"junegunn/vim-easy-align",
	event = "BufEnter",
	config = function()
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
}
