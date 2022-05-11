return {
	opt = {
		-- show whitespace characters
		list = false,
		listchars = {
			tab = "→ ",
			extends = "⟩",
			precedes = "⟨",
			trail = "·",
			nbsp = "␣",
			eol = "↲",
		},
		showbreak = "↪ ",

		scrolloff = 10,
		sidescrolloff = 15,
		numberwidth = 4,
		relativenumber = true,
		updatetime = 100,
		timeoutlen = 100,

		-- set Treesitter based folding and disable auto-folding on open
		foldenable = false,
		foldmethod = "expr",
		foldexpr = "nvim_treesitter#foldexpr()",
	},
}
