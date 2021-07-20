local textalign = {}

function textalign.setup(opts)
  local map = require('reynn.utils').map

  map({'n', 'x'}, 'ta', '<Plug>(EasyAlign)')      -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
  map({'n', 'x'}, '<leader>tal', ':LiveEasyAlign<CR>')   -- Start interactive EasyAlign in live mode
  map({'n', 'x'}, '<leader>ta=', ':EasyAlign *=<CR>')    -- Align to a `=` character
  map({'n', 'x'}, '<leader>ta-', ':EasyAlign *-<CR>')    -- Align to a `-` character
  map({'n', 'x'}, '<leader>ta ', ':EasyAlign *\\ <CR>')  -- Align to a ` ` character
end

return textalign
