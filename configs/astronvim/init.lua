return {
	cmp = {
		source_priorities = {
			nvim_lsp = 1000,
			luasnip = 500,
			path = 350,
			buffer = 300,
		},
	},
	colorscheme = "kanagawa",
	-- Extend LSP configuration
	lsp = {
		servers = {
			"ansiblels",
			"dockerls",
			"gopls",
			"jdtls",
			"rust_analyzer",
			"sumneko_lua",
			"yamlls",
		},

		-- add to the server on_attach function
		on_attach = function(client, bufnr)
			local lspsignature_ok, lspsignature = pcall(require, "lsp_signature")
			if lspsignature_ok then
				lspsignature.on_attach({
					bind = true,
					handler_opts = {
						border = "double",
					},
					transparent = 75,
				}, bufnr)
			end

			local status_ok, codelens_supported = pcall(function()
				return client.supports_method "textDocument/codeLens"
			end)
			if not status_ok or not codelens_supported then
				return
			end

			local augroup_exist, _ = pcall(vim.api.nvim_get_autocmds, {
				group = "lsp_code_lens_refresh",
			})
			if not augroup_exist then
				vim.api.nvim_create_augroup("lsp_code_lens_refresh", {})
			end
			vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
				group = "lsp_code_lens_refresh",
				buffer = bufnr,
				callback = vim.lsp.codelens.refresh,
			})

			if client.resolved_capabilities.document_formatting then
				vim.api.nvim_create_augroup("LspFormatting", {})
				vim.api.nvim_create_autocmd("BufWritePre", {
					desc = "Use LSP formatter before writing file",
					group = "LspFormatting",
					pattern = "<buffer>",
					command = "lua vim.lsp.buf.formatting_sync()",
				})
			end
		end,

		-- Add overrides for LSP server settings, the keys are the name of the server
		["server-settings"] = {
			rust_analyzer = {
				settings = {
					["rust-analyzer"] = {
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
				},
			},
      yamlls = {
        settings = {
          yaml = {
            completion = true,
            customTags = {
              "!Fn",
              "!And",
              "!If",
              "!Not",
              "!Equals",
              "!Or",
              "!FindInMap sequence",
              "!Base64",
              "!Cidr",
              "!Ref",
              "!Ref Scalar",
              "!Sub",
              "!GetAtt",
              "!GetAZs",
              "!ImportValue",
              "!Select",
              "!Split",
              "!Join sequence",
            },
            format = {
              enable = true,
              printWidth = 120,
            },
            hover = true,
            schemas = {
              ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
              ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
              ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
            },
          },
        },
      },
		},
	},
	polish = function()
		vim.filetype.add({
			pattern = {
				[".*/cfn/.*.yaml"] = "cloudformation",
				[".*.cfn.yaml"] = "cloudformation",
			},
		})

		require("user.autocmds")
		require("user.mappings")
	end,
}
