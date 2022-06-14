return function()
	require("crates").setup({})

	-- astronvim.add_cmp_source "crates"
	astronvim.add_user_cmp_source("crates")
end
