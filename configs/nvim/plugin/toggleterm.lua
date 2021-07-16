local map = require('reynn.utils').map

map("n", "<leader>gu", "<cmd>lua require('reynn.plugins.term').toggle_git_tui()<CR>", {noremap = true, silent = true})

require("toggleterm").setup{
  hide_numbers = true,
  direction = 'float',
  close_on_exit = true,
  float_opts = {
    border = 'curved',
  },
  -- size can be a number or function which is passed the current terminal
  size = 20,
  open_mapping = [[<c-\>]],
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = '2', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true
}
