return {
	["<leader>"] = {
		["/"] = {
			"Comment",
			function()
				require("mini.comment").toggle_lines()
			end,
		},
		x = {
			name = "Debugger",
			e = {
				function()
					require("dapui").eval()
				end,
				"Evaluate Line",
			},
		},
	},
}
