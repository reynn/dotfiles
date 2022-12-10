return {
	after = "nvim-treesitter",
	config = function()
		require("hlargs").setup()
	end,
}
