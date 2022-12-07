local dap_ok, _ = pcall(require, "dap")
local dap_vt_ok, dap_vt = pcall(require, "nvim-dap-virtual-text")
if not dap_vt_ok and not dap_ok then
  return
end

dap_vt.setup({})
