local utils = require('reynn.utils')
local map = utils.map

map({'n'}, '<leader>bf', '<cmd>lua require("reynn.utils").format_buffer()<CR>', {}) -- \bf to format buffer
map({'n','x'}, '<leader>cl', '<Plug>Commentary <SID>go()', {noremap = true, expr = true}) -- \cl to comment lines
