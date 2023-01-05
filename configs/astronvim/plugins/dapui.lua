return {
	icons = {
		expanded = "▾",
		collapsed = "▸",
	},
	mappings = {
		expand = "<cr>",
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	layouts = {
		{
			elements = {
				"scopes",
				"breakpoints",
				"stacks",
			},
			size = 30,
			position = "right",
		},
		{
			elements = {
				"repl",
			},
			size = 10,
			position = "bottom",
		},
	},
	floating = {
		border = "rounded",
		mappings = {
			close = {
				"q",
				"<esc>",
			},
		},
	},
	windows = {
		indent = 1,
	},
}
