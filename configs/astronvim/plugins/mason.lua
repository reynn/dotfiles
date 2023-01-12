return {
	astronvim.plugin({
		"jay-babu/mason-nvim-dap.nvim",
		opts = {
			ensure_installed = {
				"python",
				"delve",
				"codelldb",
			},
		},
	}),
	astronvim.plugin({
		"jay-babu/mason-null-ls.nvim",
		opts = {
			ensure_installed = {
				"gofumpt",
				"jsonlint",
				"markdownlint",
				"prettier",
				"revive",
				"stylua",
				"yamllint",
			},
		},
	}),
	astronvim.plugin({
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = {
				"gopls",
				"sumneko_lua",
				"bashls",
				"dockerls",
				"jedi_language_server",
				"jdtls",
				"jsonls",
				"remark_ls",
				"rust_analyzer",
				"taplo",
				"yamlls",
			},
		},
	}),
}
