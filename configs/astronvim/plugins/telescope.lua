return {
	{
		"nvim-telescope/telescope-project.nvim",
		lazy = false,
		after = "telescope.nvim",
		config = function()
			require("telescope").load_extension("project")
		end,
		module = "telescope._extensions.project",
	},
	{
		"cljoly/telescope-repo.nvim",
		lazy = false,
		after = "telescope.nvim",
		config = function()
			require("telescope").load_extension("repo")
		end,
		module = "telescope._extensions.repo",
	},
}
