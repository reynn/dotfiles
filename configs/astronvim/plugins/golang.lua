return function()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if cmp_nvim_lsp_ok then
		capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
	end
	-- local path = require("nvim-lsp-installer.core.path")
	-- local install_root_dir = path.concat({ vim.fn.stdpath("data"), "lsp_servers" })

	require("go").setup({
		goimport = "gopls",
		fillstruct = "gopls",
		gofmt = "gofumpt", --gofmt cmd,
		max_line_len = 120,
		icons = false,
		verbose = false,
		lsp_cfg = {
			capabilities = capabilities,
			settings = {
				gopls = {
					codelenses = {
						generate = true,
						gc_details = false,
						test = true,
						tidy = true,
					},
					analyses = {
						unusedparams = true,
					},
				},
			},
		},
		lsp_gofumpt = true,
		lsp_keymaps = false,
		lsp_on_attach = astronvim.lsp and astronvim.lsp.on_attach or nil,
		lsp_diag_virtual_text = true,
		lsp_document_formatting = true,
		-- gopls_cmd = { install_root_dir .. "/gopls/gopls" },
		dap_debug = true,
		dap_debug_gui = true,
		textobjects = false,
	})
end
