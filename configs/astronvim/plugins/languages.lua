return {
	{
		"ray-x/go.nvim",
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if cmp_nvim_lsp_ok then
				capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
			end

			require("go").setup({
				dap_debug = true,
				dap_debug_gui = true,
				fillstruct = "gopls",
				gofmt = "gofumpt", --gofmt cmd,
				goimport = "gopls",
				icons = false,
				lsp_cfg = {
					capabilities = capabilities,
					settings = {
						gopls = {
							codelenses = {
								gc_details = false,
								generate = true,
								test = true,
								tidy = true,
							},
							analyses = {
								unusedparams = true,
							},
						},
					},
				},
				lsp_inlay_hints = { enabled = false },
				lsp_diag_virtual_text = true,
				lsp_document_formatting = true,
				lsp_gofumpt = true,
				lsp_keymaps = false,
				lsp_on_attach = astronvim.lsp and astronvim.lsp.on_attach or nil,
				max_line_len = 120,
				textobjects = false,
				verbose = false,
			})
		end,
		ft = { "go" },
	},
	{
		"Saecki/crates.nvim",
		after = "nvim-cmp",
		event = { "BufRead Cargo.toml" },
		config = function()
			require("crates").setup({})
			-- astronvim.add_user_cmp_source("crates")
		end,
	},
	{
		"simrat39/rust-tools.nvim",
		config = function()
			local lldb_version = "1.8.1"
			local extension_path = vim.env.HOME .. "/.vscode-insiders/extensions/vadimcn.vscode-lldb-" .. lldb_version
			local codelldb_path = extension_path .. "/adapter/codelldb"
			local liblldb_path = extension_path .. "/lldb/lib/liblldb.so"

			require("rust-tools").setup({
				tools = {
					-- These apply to the default RustSetInlayHints command
					inlay_hints = {
						auto = false,
						parameter_hints_prefix = " ",
						other_hints_prefix = " ",
					},
				},
				server = astronvim.lsp.server_settings("rust_analyzer"),
				dap = {
					adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			})
		end,
		ft = { "rust" },
	},
}
