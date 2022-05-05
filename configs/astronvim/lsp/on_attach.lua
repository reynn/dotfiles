return function(client, bufnr)
	local lspconfig_ok, lspconfig = pcall(require, "lspconfig")
	local aerial_ok, aerial = pcall(require, "aerial")
	local lspsignature_ok, lspsignature = pcall(require, "lsp_signature")

	if lspsignature_ok then
		lspsignature.on_attach({
			bind = true,
			handler_opts = {
				border = "rounded",
			},
		}, bufnr)
	end
end
