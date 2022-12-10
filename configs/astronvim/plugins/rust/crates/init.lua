return {
	after = "nvim-cmp",
	event = { "BufRead Cargo.toml" },
	requires = { "plenary.nvim" },
	config = function()
		require("crates").setup({})

		-- astronvim.add_cmp_source "crates"
		astronvim.add_user_cmp_source("crates")
	end,
}
