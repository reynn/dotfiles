local statusline = {
  configs = {
    default = {}
  }
}

function statusline.configs.default.init(opts)
  require("lualine").setup(
    {
      options = {
        icons_enabled = true,
        theme = opts.theme or "gruvbox"
      },
      sections = opts.sections or
        {
          lualine_a = {"mode"},
          lualine_b = {"branch"},
          lualine_c = {"filename"},
          lualine_x = {{require("lsp-status").status, condition = statusline.lspStatus}},
          lualine_y = {"filetype"},
          lualine_z = {"location"}
        }
    }
  )
end

function statusline.setup(opts)
  statusline.configs.default.init(opts.default or {})
end

function statusline.lspStatus()
  local tbl = {["dashboard"] = true, [" "] = true}
  if tbl[vim.bo.filetype] then
    return false
  end
  return true
end

return statusline
