local M = {}

M.alpha_on_bye = function(cmd)
  local bufs = vim.fn.getbufinfo({ buflisted = true })
  vim.cmd(cmd)
  if require("core.utils").is_available("alpha-nvim") and not bufs[2] then
    require("alpha-nvim").start(true)
  end
end

return M
