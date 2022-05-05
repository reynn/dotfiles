return function()
	require("neogen").setup({
		snippet_engine = "luasnip",
		languages = {
			python = {
				template = {
					annotation_convention = "google_docstrings",
				},
			},
			go = {
				template = {
					annotation_convention = "godoc",
				},
			},
			java = {
				template = {
					annotation_convention = "javadoc",
				},
			},
			rust = {
				template = {
					annotation_convention = "rustdoc",
				},
			},
		},
	})
end
