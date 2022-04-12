return function()
	local set = vim.opt

	-- show whitespace characters
	set.list = true
	set.listchars = {
		tab = "│→",
		extends = "⟩",
		precedes = "⟨",
		trail = "·",
		nbsp = "␣",
	}
	set.showbreak = "↪ "
	-- soft wrap lines

	set.scrolloff = 15
	set.sidescrolloff = 15
	set.numberwidth = 4

	-- Set options
	set.relativenumber = true

	-- set Treesitter based folding and disable auto-folding on open
	set.foldenable = false
	set.foldmethod = "expr"
	set.foldexpr = "nvim_treesitter#foldexpr()"

	-- Auto Commands
	require("user.autocmds").setup()
end
