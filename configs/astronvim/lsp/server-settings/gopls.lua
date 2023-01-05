return {
	settings = {
		-- to enable rust-analyzer settings visit:
		-- https://github.com/rust-lang/rust-analyzer/blob/master/docs/user/generated_config.adoc
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
}
