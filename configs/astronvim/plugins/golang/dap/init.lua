return {
	config = function()
		local dap_ok, _ = pcall(require, "dap")
		if not dap_ok then
			return
		end

		require("dap-go").setup({})
	end,
}
