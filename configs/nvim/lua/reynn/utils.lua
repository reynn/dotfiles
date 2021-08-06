local utils = {}

local cmd = vim.cmd
local o_s = vim.o
local map_key = vim.api.nvim_set_keymap
local buf_map_key = vim.api.nvim_buf_set_keymap

return {
  opt = function(o, v, scopes)
    scopes = scopes or {o_s}
    for _, s in ipairs(scopes) do
      s[o] = v
    end
  end,
  autocmd = function(group, cmds, clear)
    clear = clear == nil and false or clear
    if type(cmds) == "string" then
      cmds = {cmds}
    end
    cmd("augroup " .. group)
    if clear then
      cmd [[au!]]
    end
    for _, c in ipairs(cmds) do
      cmd("autocmd " .. c)
    end
    cmd [[augroup END]]
  end,
  -- Configure a Keymap, example:
  map = function(modes, lhs, rhs, opts)
    opts = opts or {}
    opts.noremap = opts.noremap == nil and true or opts.noremap
    if type(modes) == "string" then
      modes = {modes}
    end
    for _, mode in ipairs(modes) do
      map_key(mode, lhs, rhs, opts)
    end
  end,
  bufmap = function(bufnr, modes, lhs, rhs, opts)
    opts = opts or {}
    opts.noremap = opts.noremap == nil and true or opts.noremap
    if type(modes) == "string" then
      modes = {modes}
    end
    for _, mode in ipairs(modes) do
      buf_map_key(bufnr, mode, lhs, rhs, opts)
    end
  end,
  replace_termcodes = function(code)
    return vim.api.nvim_replace_termcodes(code, true, true, true)
  end,
  current_mode = function(mode)
    return utils.modes()[mode]
  end,
  modes = function()
    local colors = require("reynn.themes").colors
    return {
      n = {color = colors.red, name = "normal"},
      no = {color = colors.red, name = "n·op"},
      i = {color = colors.green, name = "insert"},
      v = {color = colors.blue, name = "visual"},
      V = {color = colors.blue, name = "v·line"},
      [""] = {color = colors.blue, name = "v·b"},
      c = {color = colors.magenta, name = "command"},
      s = {color = colors.orange, name = "select"},
      S = {color = colors.orange, name = "s·line"},
      [""] = {color = colors.orange, name = "s·b"},
      ic = {color = colors.yellow, name = "i·completion"},
      R = {color = colors.violet, name = "replace"},
      Rv = {color = colors.violet, name = "v·r"},
      cv = {color = colors.red, name = "vim·ex"},
      ce = {color = colors.red, name = "ex"},
      r = {color = colors.cyan, name = "prompt"},
      rm = {color = colors.cyan, name = "more"},
      ["r?"] = {color = colors.cyan, name = "confirm"},
      ["!"] = {color = colors.red, name = "shell"},
      t = {color = colors.red, name = "terminal"}
    }
  end,
  check_back_space = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
  end
}