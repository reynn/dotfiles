return {
	config = function()
		require("mason-tool-installer").setup({
			auto_update = true,
			ensure_installed = {
				-- LSPs
				"lua-language-server",
				"rust-analyzer",
				"gopls", -- golang
				"dockerfile-language-server",
				"ansible-language-server",
				"jdtls", -- java
				"json-lsp", -- jsono
				"taplo", -- yaml

				-- formatters
				"black", -- pythno
				"isort",
				"shfmt", -- bash
				"stylua", -- lua

				-- DAP
				"delve", -- go
				"codelldb", -- rust

				-- Linters
				"revive", -- go
			},
			run_on_start = true,
		})
	end,
}
