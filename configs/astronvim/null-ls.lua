return function()
	local null_ls_ok, null_ls = pcall(require, "null-ls")

	if null_ls_ok then
		local builtins = null_ls.builtins
		local helpers = require("null-ls.helpers")

		local cfn_lint = {
			name = "cfn-lint",
			method = null_ls.methods.DIAGNOSTICS,
			filetypes = { "cloudformation" },
			generator = helpers.generator_factory({
				command = "cfn-lint",
				to_stdin = true,
				to_stdout = true,
				format = "line",
				args = { "--format", "parseable", "-" },
				check_exit_code = function(code)
					return code == 0 or code == 255
				end,
				on_output = helpers.diagnostics.from_patterns({
					{
						pattern = [[:(%d+):(%d+):(%d+):(%d+):(.*):(.*)]],
						groups = { "row", "col", "end_row", "end_col", "code", "message" },
					},
				}),
			}),
		}

		null_ls.setup({
			debug = false,
			sources = {
				builtins.code_actions.shellcheck,
				builtins.formatting.stylua,
				builtins.formatting.isort,
				builtins.formatting.shfmt,
				builtins.diagnostics.cue_fmt,
				builtins.diagnostics.fish,
				builtins.diagnostics.trail_space,
				builtins.diagnostics.revive,
				builtins.diagnostics.shellcheck,
				cfn_lint,
			},
		})
	end
end
