local utils = require('reynn.utils')
local map = utils.map

map({'n', 'x'}, 'ta', '<Plug>(EasyAlign)')      -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
map('x', '<leader>tal', ':LiveEasyAlign<CR>')   -- Start interactive EasyAlign in live mode
map('x', '<leader>ta=', ':EasyAlign *=<CR>')    -- Align to a `=` character
map('x', '<leader>ta-', ':EasyAlign *-<CR>')    -- Align to a `-` character
map('x', '<leader>ta ', ':EasyAlign *\\ <CR>')  -- Align to a ` ` character
