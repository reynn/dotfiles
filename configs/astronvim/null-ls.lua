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
				builtins.diagnostics.rubocop,
				builtins.diagnostics.shellcheck,
				cfn_lint,
			},
			on_attach = function(client)
				-- vim.notify(client.name, "info", { title = "Language Server", timeout = 500 })
				if client.resolved_capabilities.document_formatting then
					vim.api.nvim_create_autocmd("BufWritePre", {
						desc = "Auto format before save",
						pattern = "<buffer>",
						callback = vim.lsp.buf.formatting_sync,
					})
				end
			end,
		})
	end
end
