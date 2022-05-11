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

		fillchars = {
			horiz = "━",
			horizup = "┻",
			horizdown = "┳",
			vert = "┃",
			vertleft = "┨",
			vertright = "┣",
			verthoriz = "╋",
		},
		laststatus = 3,

		numberwidth = 4,
		relativenumber = true,
		scrolloff = 10,
		sidescrolloff = 15,
		timeoutlen = 100,
		updatetime = 100,

		-- set Treesitter based folding and disable auto-folding on open
		foldenable = false,
		foldmethod = "expr",
		foldexpr = "nvim_treesitter#foldexpr()",
	},
}
