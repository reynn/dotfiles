return {
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
}
