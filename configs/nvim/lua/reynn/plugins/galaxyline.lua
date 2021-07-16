local M = {}

M.default = {}
function M.default.setup()
  local gl = require('galaxyline')
  local gls = gl.section
  gl.short_line_list = { 'TelescopePrompt', 'nnn' }

  local diagnostic = require('galaxyline.provider_diagnostic')
  local vcs = require('galaxyline.provider_vcs')
  local fileinfo = require('galaxyline.provider_fileinfo')
  local extension = require('galaxyline.provider_extensions')
  local buffer = require('galaxyline.provider_buffer')
  local whitespace = require('galaxyline.provider_whitespace')
  local lspclient = require('galaxyline.provider_lsp')

  local colors = {
    base0 = '#1B2229',
    base1 = '#1c1f24',
    base2 = '#202328',
    base3 = '#23272e',
    base4 = '#3f444a',
    base5 = '#5B6268',
    base6 = '#73797e',
    base7 = '#9ca0a4',
    base8 = '#b1b1b1',

    bg = '#282a36',
    bg1 = '#504945',
    bg_popup = '#3E4556',
    bg_highlight  = '#2E323C',
    bg_visual = '#b3deef',

    fg = '#bbc2cf',
    fg_alt  = '#5B6268',

    red = '#e95678',

    redwine = '#d16d9e',
    orange = '#D98E48',
    yellow = '#f0c674',

    light_green = '#abcf84',
    green = '#afd700',
    dark_green = '#98be65',

    cyan = '#36d0e0',
    blue = '#61afef',
    violet = '#b294bb',
    magenta = '#c678dd',
    teal = '#1abc9c',
    grey = '#928374',
    brown = '#c78665',
    black = '#000000',

    bracket = '#80A0C2',
    currsor_bg = '#4f5b66',
    none = 'NONE',
  }

  local mode_provider = function()
    local alias = {
      n      = 'NORMAL ',
      i      = 'INSERT ',
      c      = 'COMMAND ',
      cv     = 'COMMAND ',
      ce     = 'COMMAND ',
      v      = 'VISUAL ',
      V      = 'VISUAL-L ',
      ['']   = 'VISUAL-B ',
      s      = 'SELECT ',
      S      = 'SELECT-L ',
      ['']   = 'SELECT-B ',
      R      = 'REPLACE ',
      Rc     = 'REPLACE ',
      Rv     = 'REPLACE ',
      Rx     = 'REPLACE ',
    }
    return alias[vim.fn.mode()]
  end

  local space_provider = function()
    return ' '
  end

  local line_info_provider = function()
    local bufnr = vim.fn.bufnr()
    local bufinfo = vim.fn.getbufinfo(bufnr)
    bufinfo = bufinfo[1]
    local linecount = bufinfo.linecount
    local linenum = bufinfo.lnum
    local col = vim.fn.col('.')
    return string.format('%s/%s:%s', linenum, linecount, col)
  end

  local lsp_error_provider = function()
    local bufnr = vim.fn.bufnr()
    local errors = vim.lsp.diagnostic.get_count(bufnr, [[Error]])
    if errors ~= 0 then return string.format('E:%s ', errors) end
    return ''
  end

  local lsp_warning_provider = function()
    local bufnr = vim.fn.bufnr()
    local warnings = vim.lsp.diagnostic.get_count(bufnr, [[Warning]])
    if warnings ~= 0 then return string.format('W:%s ', warnings) end
    return ''
  end

  local lsp_text_provider = function()
    local clients = vim.lsp.buf_get_clients()
    if vim.tbl_isempty(clients) then return '' end
    return 'LSP'
  end

  local show_if_buf_exists = function()
    local bufname = vim.fn.expand('%:t')
    if vim.fn.empty(bufname) == 1 then return false end
    return true
  end

  local function is_insert_mode()
    return vim.fn.mode() == 'i'
  end

  --[[
  -- Active Statusline
  --]]
  gls.left = {
    -- Vim Mode {{
    {
      VimModeSpaceBeforer = {
        provider = space_provider,
        highlight = { colors.bg, colors.teal },
      },
    },

    {
      VimMode = {
        provider = mode_provider,
        highlight = { colors.bg, colors.teal },
        separator = '',
        separator_highlight = { colors.teal, colors.bg },
      },
    },
    -- }}

    -- Git {{
    {
      GitBranchSpaceBefore = {
        provider = space_provider,
        highlight = { colors.bg, colors.bg },
      },
    },

    {
      GitBranch = {
        provider = vcs.get_git_branch,
        highlight = { colors.fg, colors.bg },
        icon = ' ',
      },
    },

    {
      GitBranchSpaceAfter = {
        provider = space_provider,
        highlight = { colors.fg, colors.bg },
        separator = '',
        separator_highlight = {
          colors.bg,
          function()
            if show_if_buf_exists() then
              return colors.blue
            else
              return colors.bg
            end
          end
        },
      },
    },
    -- }}

    -- File Info {{
    {
      FileInfoSpaceBefore = {
        provider = space_provider,
        condition = show_if_buf_exists,
        highlight = { colors.blue, colors.blue },
      },
    },

    {
      FileIcon = {
        provider = fileinfo.get_file_icon,
        condition = show_if_buf_exists,
        highlight = { colors.bg, colors.blue },
      },
    },

    {
      Filename = {
        provider = fileinfo.get_current_file_name,
        condition = show_if_buf_exists,
        highlight = { colors.bg, colors.blue },
        separator = '',
        separator_highlight = { colors.blue, colors.bg },
      },
    },
    -- }}
  }

  -- Right Side
  gls.right = {
    -- File Encoding/Format {{
    {
      FileEncoding = {
        provider = fileinfo.get_file_encode,
        highlight = { colors.bg, colors.redwine },
        separator = '',
        separator_highlight = { colors.redwine, colors.bg },
      },
    },

    {
      FileEncodingSpaceAfter = {
        provider = space_provider,
        highlight = { colors.redwine, colors.redwine },
      },
    },

    {
      FileFormat = {
        provider = fileinfo.get_file_format,
        highlight = { colors.bg, colors.redwine },
      },
    },

    {
      FileFormatSpaceAfter = {
        provider = space_provider,
        highlight = { colors.redwine, colors.redwine },
      },
    },
    -- }}

    -- Line Info {{
    {
      LineInfoSpaceBefore = {
        provider = space_provider,
        condition = show_if_buf_exists,
        highlight = { colors.bg, colors.bg },
        separator = '',
        separator_highlight = { colors.bg, colors.redwine },
      },
    },

    {
      LineInfo = {
        provider = line_info_provider,
        condition = show_if_buf_exists,
        highlight = { colors.fg, colors.bg },
      },
    },

    {
      LineInfoSpaceAfter = {
        provider = space_provider,
        condition = show_if_buf_exists,
        highlight = { colors.bg, colors.bg },
      },
    },
    -- }}

    -- LSP Status {{
    {
      LspInfoSpaceBefore = {
        provider = space_provider,
        highlight = { colors.fg_alt, colors.fg_alt },
        separator = '',
        separator_highlight = {
          colors.fg_alt,
          function()
            if show_if_buf_exists() then
              return colors.bg
            else
              return colors.redwine
            end
          end
        },
      },
    },

    {
      LspErrorInfo = {
        provider = lsp_error_provider,
        highlight = { colors.red, colors.fg_alt },
      },
    },

    {
      LspWarningInfo = {
        provider = lsp_warning_provider,
        highlight = { colors.yellow, colors.fg_alt },
      },
    },

    {
      LspInfo = {
        provider = lsp_text_provider,
        highlight = { colors.fg, colors.fg_alt },
      },
    },

    {
      LspInfoSpaceAfter = {
        provider = space_provider,
        highlight = { colors.fg_alt, colors.fg_alt },
      },
    },
    -- }}
  }

  --[[
  -- Inactive Statusline
  --]]
  gls.short_line_left = {
    {
      FileSpaceBefore = {
        provider = space_provider,
        highlight = { colors.blue, colors.blue },
      },
    },

    {
      FileIcon = {
        provider = fileinfo.get_file_icon,
        highlight = { colors.bg, colors.blue },
      },
    },

    {
      Filename = {
        provider = fileinfo.get_current_file_name,
        highlight = { colors.bg, colors.blue },
        separator = '',
        separator_highlight = { colors.blue, colors.bg },
      },
    },
  }

  gls.short_line_right = {
    -- File Encoding/Format {{
    {
      FileEncoding = {
        provider = fileinfo.get_file_encode,
        highlight = { colors.bg, colors.redwine },
        separator = '',
        separator_highlight = { colors.redwine, colors.bg },
      },
    },

    {
      FileEncodingSpaceAfter = {
        provider = space_provider,
        highlight = { colors.redwine, colors.redwine },
      },
    },

    {
      FileFormat = {
        provider = fileinfo.get_file_format,
        highlight = { colors.bg, colors.redwine },
      },
    },

    {
      FileFormatSpaceAfter = {
        provider = space_provider,
        highlight = { colors.redwine, colors.redwine },
      },
    },
    -- }}
  }
end


M.uttarayan21 = {}
function M.uttarayan21.setup()
  local vim = vim
  local gl = require('galaxyline')

  local condition = require('galaxyline.condition')
  -- local diagnostic = require('galaxyline.provider_diagnostic')
  -- local diagnostics = require('lsp-status.diagnostics')
  local vcs = require('galaxyline.provider_vcs')
  local fileinfo = require('galaxyline.provider_fileinfo')
  -- local extension = require('galaxyline.provider_extensions')
  -- local colors = require('galaxyline.colors')
  -- local buffer = require('galaxyline.provider_buffer')
  -- local whitespace = require('galaxyline.provider_whitespace')
  -- local lspclient = require('galaxyline.provider_lsp')
  local lspstatus = require('lsp-status')

  -- local gls = gl.section
  gl.short_line_list = { 'defx' }

  -- from sonokai theme (https://github.com/sainnhe/sonokai/blob/master/autoload/sonokai.vim)
  local colors = {
      dark_black  = '#151515',
      black       = '#181819',
      bg0         = '#2c2e34',
      bg1         = '#30323a',
      bg2         = '#363944',
      bg3         = '#3b3e48',
      bg4         = '#414550',

      bg_red      = '#ff6077',
      diff_red    = '#55393d',

      bg_green    = '#a7df78',
      diff_green  = '#394634',

      bg_blue     = '#85d3f2',
      diff_blue   = '#354157',

      yellow      = '#e7c664',
      diff_yellow = '#4e432f',

      fg          = '#e2e2e3',

      red         = '#fc5d7c',
      orange      = '#f39660',
      green       = '#9ed072',
      blue        = '#76cce0',
      purple      = '#b39df3',
      grey        = '#7f8490',
      none        = 'NONE',
  }


  local mode_color = function()
      local mode_colors = {
          n       = colors.blue,
          i       = colors.green,
          c       = colors.yellow,
          V       = colors.purple,
          ['']    = colors.purple,
          v       = colors.purple,
          R       = colors.red,
      }

      local color = mode_colors[vim.fn.mode()]

      if color == nil then
          color = colors.red
      end

      return color
  end


  local gls = gl.section

  gls.left[1] = {
      ViMode = {
          provider = function()
              local alias = {
                  n = 'NORMAL',
                  i = 'INSERT',
                  c = 'COMMAND',
                  V = 'VISUAL',
                  [''] = 'VISUAL',
                  v = 'VISUAL',
                  R = 'REPLACE',
              }
              vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color())
              local alias_mode = alias[vim.fn.mode()]
              if alias_mode == nil then
                  alias_mode = vim.fn.mode()
              end
              return '▋ '..alias_mode..' '
          end,
          highlight = { colors.fg , colors.bg2 },
          separator = '',
          separator_highlight = { colors.bg2 ,
                  function()
                      if condition.check_git_workspace() then
                          return colors.bg1
                      else
                          return colors.dark_black
                      end
                  end
          },

      }
  }

  gls.left[2] = {
      GitBranch = {
          provider = function() return vcs.get_git_branch()..' ' end,
          condition = condition.check_git_workspace,
          highlight = { colors.purple , colors.bg1 },
          icon = '  ',
          separator = '',
          separator_highlight = { colors.bg1 , colors.dark_black },
      }
  }

  gls.left[3] = {
    ShowLspStatus = {
      provider = lspstatus.status,
      highlight = { colors.grey , colors.dark_black, 'bold' }
    }
  }


  -- Right Side
  gls.right[1]= {
    FileFormat = {
      provider = function() return ' '..fileinfo.get_file_format()..' ' end,
      highlight = { colors.purple, colors.bg3 },
      separator = '',
      separator_highlight = { colors.bg3, colors.dark_black },
    }
  }
  gls.right[2] = {
    LineInfo = {
      provider = 'LineColumn',
      highlight = { colors.grey, colors.bg2 },
      separator = '',
      separator_highlight = { colors.bg2, colors.bg3 },
    },
  }
  gls.right[3] = {
    PerCent = {
      provider = 'LinePercent',
      highlight = { colors.blue, colors.bg1 },
      separator = '',
      separator_highlight = { colors.bg1 , colors.bg2 },
    }
  }
end


M.hyperbolist = {}
function M.hyperbolist.setup()
  local gl = require('galaxyline')
  local condition = require('galaxyline.condition')
  local gls = gl.section

  local colors = {
    bg = '#2e2e2e',
    yellow = '#f0c674',
    cyan = '#8abeb7',
    green = '#b5bd68',
    orange = '#de935f',
    purple = '#b294bb',
    magenta = '#D16D9E',
    grey = '#969896',
    blue = '#81a2be',
    red = '#cc6666',
    bright_grey = '#c8c8c8'
  }
  local icons = {
    diagnostic = {
      error = '  ',
      warn = '  ',
      hint = '  ',
      info = '  ',
    },
    diff = {
      add = '  ',
      modified = ' 柳',
      remove = '  ',
    },
    git = '',
    bar = '▊',
    lsp = '  ',
  }

  gl.short_line_list = {'NvimTree', 'vista', 'packer'}

  gls.left[1] = {
    ViMode = {
      provider = function()
        -- auto change color according the vim mode
        local mode_color = {
          R = colors.red,
          Rv = colors.red,
          S = colors.yellow,
          V = colors.yellow,
          [''] = colors.yellow,
          [''] = colors.yellow,
          ['!'] = colors.green,
          ['r?'] = colors.cyan,
          c = colors.purple,
          ce = colors.purple,
          cv = colors.purple,
          i = colors.blue,
          ic = colors.blue,
          n = colors.green,
          no = colors.green,
          r = colors.cyan,
          rm = colors.cyan,
          s = colors.yellow,
          t = colors.green,
          v = colors.yellow,
        }
        vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[vim.fn.mode()])
        return icons.bar .. ' '
      end,
      highlight = {colors.red, colors.bg, 'bold'},
    }
  }

  gls.left[2] = {
    GitIcon = {
      provider = function()
        return icons.git
      end,
      condition = condition.check_git_workspace,
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.purple, colors.bg, 'bold'}
    }
  }

  gls.left[3] = {
    GitBranch = {
      provider = 'GitBranch',
      condition = condition.check_git_workspace,
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.purple, colors.bg, 'bold'}
    }
  }
  gls.left[4] = {
    FileName = {
      provider = 'FileName',
      -- provider = function()
        -- return vim.fn.expand("%:F")
        -- return vim.fn.expand("%")
      -- end,
      condition = condition.buffer_not_empty,
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.bright_grey, colors.bg, 'bold'}
    }
  }
  gls.left[5] = {
    DiffAdd = {
      provider = 'DiffAdd',
      condition = condition.hide_in_width,
      icon = icons.diff.add,
      highlight = {colors.green, colors.bg}
    }
  }
  gls.left[6] = {
    DiffModified = {
      provider = 'DiffModified',
      condition = condition.hide_in_width,
      icon = icons.diff.modified,
      highlight = {colors.blue, colors.bg}
    }
  }
  gls.left[7] = {
    DiffRemove = {
      provider = 'DiffRemove',
      condition = condition.hide_in_width,
      icon = icons.diff.remove,
      highlight = {colors.red, colors.bg}
    }
  }

  gls.right[1] = {
    DiagnosticError = {
      provider = 'DiagnosticError',
      icon = icons.diagnostic.error,
      highlight = {colors.red, colors.bg}
    }
  }
  gls.right[2] = {
    DiagnosticWarn = {
      provider = 'DiagnosticWarn',
      icon = icons.diagnostic.warn,
      highlight = {colors.orange, colors.bg}
    }
  }

  gls.right[3] = {
    DiagnosticHint = {
      provider = 'DiagnosticHint',
      icon = icons.diagnostic.hint,
      highlight = {colors.blue, colors.bg}
    }
  }

  gls.right[4] = {
    DiagnosticInfo = {
      provider = 'DiagnosticInfo',
      icon = icons.diagnostic.info,
      highlight = {colors.blue, colors.bg}
    }
  }

  gls.right[5] = {
    ShowLspClient = {
      provider = 'GetLspClient',
      condition = function()
        local tbl = {['dashboard'] = true, [' '] = true}
        if tbl[vim.bo.filetype] then return false end
        return true
      end,
      icon = icons.lsp,
      highlight = {colors.grey, colors.bg, 'bold'}
    }
  }

  gls.right[6] = {
    LineInfo = {
      provider = 'LineColumn',
      separator = '  ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.grey, colors.bg}
    }
  }

  gls.right[7] = {
    PerCent = {
      provider = 'LinePercent',
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.grey, colors.bg, 'bold'}
    }
  }

  gls.short_line_left[1] = {
    BufferType = {
      provider = 'FileTypeName',
      separator = ' ',
      separator_highlight = {'NONE', colors.bg},
      highlight = {colors.grey, colors.bg, 'bold'}
    }
  }

  gls.short_line_left[2] = {
    SFileName = {
      provider = 'SFileName',
      condition = condition.buffer_not_empty,
      highlight = {colors.grey, colors.bg, 'bold'}
    }
  }

  gls.short_line_right[1] = {
    BufferIcon = {provider = 'BufferIcon', highlight = {colors.grey, colors.bg}}
  }
end

M.gzygmanski = {}
function M.gzygmanski.setup()
  local gl = require('galaxyline')
  local gls = gl.section
  local condition = require('galaxyline.condition')
  local vcs = require('galaxyline.provider_vcs')
  local buffer = require('galaxyline.provider_buffer')
  local fileinfo = require('galaxyline.provider_fileinfo')
  local diagnostic = require('galaxyline.provider_diagnostic')
  local lspclient = require('galaxyline.provider_lsp')
  local icons = require('galaxyline.provider_fileinfo').define_file_icon()

  -- get current file name
  local function file_readonly()
    if vim.bo.filetype == 'help' then
      return ''
    end
    if vim.bo.readonly == true then
      return "  "
    end
    return ''
  end

  local function get_current_file_name()
    local file = vim.fn.expand('%:t')
    if vim.fn.empty(file) == 1 then return '' end
    if string.len(file_readonly()) ~= 0 then
      return file .. file_readonly()
    end
    if vim.bo.modifiable then
      if vim.bo.modified then
        return '樂' .. file
      end
    end
    return file .. ' '
  end

  local colors = {
      -- polar night
      nord1 = '#2e3440',
      nord2 = '#3b4252',
      nord3 = '#434c5e',
      nord4 = '#4c566a',
      -- snow storm
      nord5 = '#d8dee9',
      nord6 = '#e5e9f0',
      nord7 = '#eceff4',
      -- frost
      nord8 = '#8fbcbb',
      nord9 = '#88c0d0',
      nord10 = '#81a1c1',
      nord11 = '#5e81ac',
      -- aurora
      nord12 = '#bf616a', -- red
      nord13 = '#d08770', -- orange
      nord14 = '#ebcb8b', -- yellow
      nord15 = '#a3be8c', -- green
      nord16 = '#b48ead', -- purple
  }

  icons['man'] = {colors.green, ''}

  function condition.checkwidth()
    local squeeze_width  = vim.fn.winwidth(0) / 2
    if squeeze_width > 50 then
      return true
    end
      return false
  end

  gls.left = {
      {
          Mode = {
              provider = function()
                  local alias = {n = 'NORMAL', i = 'INSERT', c = 'COMMAND', V= 'VISUAL', [''] = 'VISUAL'}
                  if not condition.checkwidth() then
                      alias = {n = 'N', i = 'I', c = 'C', V= 'V', [''] = 'V'}
                  end
                  return string.format('   %s  ', alias[vim.fn.mode()])
                  -- 
              end,
              highlight = {colors.nord6, colors.nord12, 'bold'},
          }
      },
      {
          FillWhenEmptyBuffer = {
              provider = function() return '' end,
              highlight = {colors.nord6, colors.nord3}
          }
      },
      {
          FileName = {
              provider = function()
                return string.format('   %s', get_current_file_name())
              end,
              condition = condition.buffer_not_empty,
              highlight = {colors.nord6, colors.nord3}
          }
      },
      -- {
      --     GitBranch = {
      --         provider = function()
      --           if vim.bo.filetype ~= 'help' then
      --             return string.format('   %s ', vcs.get_git_branch())
      --           end
      --         end,
      --         -- provider = function() return string.format('  %s ', vcs.get_git_branch()) end,
      --         condition = function() return condition.check_git_workspace() and condition.checkwidth() end,
      --         highlight = {colors.nord6, colors.nord3}
      --     }
      -- },
  }

  gls.right = {
      {
          Blank = {
              provider = function() return '   ' end,
              condition = function() return buffer.get_buffer_filetype() ~= '' end,
              highlight = {colors.nord6, colors.nord2}
          }
      },
      {
          FileIcon = {
              provider = fileinfo.get_file_icon,
              condition = function() return buffer.get_buffer_filetype() ~= '' end,
              highlight = {
                  colors.nord6,
                  colors.nord2
              },
          },
      },
      {
          FileType = {
              provider = function() return string.format('  %s  ', buffer.get_buffer_filetype()) end,
              condition = function() return buffer.get_buffer_filetype() ~= '' end,
              highlight = {colors.nord6, colors.nord2}
          }
      },
      {
          LineInfo = {
              provider = function() return string.format('   %s  ', fileinfo.line_column()) end,
              highlight = {colors.nord6, colors.nord4}
          }
      },
  }

  gl.short_line_list = {'NvimTree'}
  gls.short_line_left = {
      {
          BufferName = {
              provider = function()
                  if vim.fn.index(gl.short_line_list, vim.bo.filetype) ~= -1 then
                      local filetype = vim.bo.filetype
                      if filetype == 'NvimTree' then
                          return '     Explorer  '
                      end
                  else
                      if fileinfo.get_current_file_name() ~= '' then
                          return string.format('   %s ', get_current_file_name())
                      else
                          return '   Buffer  '
                      end
                  end
              end,
              separator = '',
              highlight = {colors.nord6, colors.nord3}
          }
      },
      -- {
      --     FillWhenEmptyBuffer = {
      --         provider = function() return '' end,
      --         condition = not condition.buffer_not_empty,
      --         highlight = {colors.nord6, colors.nord3}
      --     }
      -- },
  }
end

return M
