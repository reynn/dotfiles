require('mini.bufremove').setup({})
require('mini.comment').setup({})
require('mini.surround').setup({})
require('mini.statusline').setup({})
require('mini.indentscope').setup({
  draw = {
    delay = 0,
  },
  options = {
    indent_at_cursor = false,
  },
  symbol = "▏",
})
