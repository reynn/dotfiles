return {
	ft = { "go" },
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
}
