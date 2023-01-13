return {
	formatting = {
		format_on_save = { -- enable or disable automatic formatting on save
			enabled = true,
		},
		timeout_ms = 1500, -- adjust the timeout_ms variable for formatting
	},
	config = {
		gopls = {
			settings = {
				gopls = {
					hints = {
						assignVariableTypes = true,
						compositeLiteralFields = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
				},
			},
		},
		jsonls = {
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
				},
			},
		},
		rust_analyzer = {
			settings = {
				-- to enable rust-analyzer settings visit:
				-- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
				["rust-analyzer"] = {
					cargo = { allFeatures = true },
					-- enable clippy diagnostics on save
					checkOnSave = {
						command = "clippy",
						extraArgs = { "--no-deps" },
					},
				},
			},
		},
		yamlls = {
			settings = {
				yaml = {
					completion = true,
					-- add tags to support CloudFormation templates
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
						"!Ref",
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
						["https://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
						["https://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
						["https://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
						["https://json.schemastore.org/rustfmt.json"] = "rustfmt.toml",
					},
					schemaStore = {
						enable = true,
					},
				},
			},
		},
	},
}
