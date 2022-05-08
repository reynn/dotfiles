return {
	server = {
		path = "~/.local/share/nvim/lsp_servers/rust/rust-analyzer",
	},
	inlayHints = {
		closureReturnTypeHints = true,
	},
	diagnostics = {
		enableExperimental = true,
	},
	hoverActions = {
		references = true,
	},
	lens = {
		references = true,
	},
}
