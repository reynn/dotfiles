return {
	colorscheme = "catpuccin",
	cmp = {
		source_priority = {
			nvim_lsp = 1000,
			buffer = 500,
			luasnip = 200,
		},
	},
	lsp = {
		servers = {
			"sumneko_lua",
			"ansiblels",
			"bashls",
			"dockerls",
			"golangci_lint_ls",
			"gopls",
			"graphql",
			"jdtls",
			"rust_analyzer",
			"sumneko_lua",
			"yamlls",
		},
		["server-settings"] = {
			gopls = {},
			rust_analyzer = {
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
			},
			yamlls = {
				schemas = {
					["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
					["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
					["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
				},
			},
		},
	},
	ui = {
		nui_input = true,
	},
}
