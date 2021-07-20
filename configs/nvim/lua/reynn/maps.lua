return {
  setup = function(opts)
    local map = require('reynn.utils').map

    map({'n','x'}, '<leader>cl', '<Plug>Commentary <SID>go()', {}) -- \cl to comment lines
  end
}
