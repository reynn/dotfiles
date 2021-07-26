local statusline = {
  configs = {
    default = {}
  },
  icons = {
    diagnostic = {
      error = " ",
      warn = " ",
      hint = " ",
      info = " "
    },
    diff = {
      add = " ",
      modified = "柳",
      remove = " "
    },
    git = "",
    bar = "▊",
    lsp = " "
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
          lualine_c = {
            "filename",
            {
              "diagnostics",
              -- table of diagnostic sources, available sources:
              -- nvim_lsp, coc, ale, vim_lsp
              sources = {"nvim_lsp"},
              -- displays diagnostics from defined severity
              sections = {"error", "warn", "info", "hint"},
              -- all colors are in format #rrggbb
              color_error = nil, -- changes diagnostic's error foreground color
              color_warn = nil, -- changes diagnostic's warn foreground color
              color_info = nil, -- Changes diagnostic's info foreground color
              color_hint = nil, -- Changes diagnostic's hint foreground color
              symbols = {
                error = statusline.icons.diagnostic.error,
                warn = statusline.icons.diagnostic.warn,
                info = statusline.icons.diagnostic.info,
                hint = statusline.icons.diagnostic.hint
              },
              condition = statusline.lspStatus
            }
          },
          lualine_x = {{require("lsp-status").status, condition = statusline.lspStatus}},
          lualine_y = {
            {"filetype", lower = true}
          },
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
