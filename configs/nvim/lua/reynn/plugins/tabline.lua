local tabline = {}

function tabline.setup(opts)
  local map = require('reynn.utils').map

  vim.g.bufferline = {
    animation = false,
  }

  map({'n', 'x'}, '<leader>1', '<cmd>:BufferGoto 1<cr>', {noremap = true})
  map({'n', 'x'}, '<leader>2', '<cmd>:BufferGoto 2<cr>', {noremap = true})
  map({'n', 'x'}, '<leader>3', '<cmd>:BufferGoto 3<cr>', {noremap = true})
  map({'n', 'x'}, '<leader>4', '<cmd>:BufferGoto 4<cr>', {noremap = true})
  map({'n', 'x'}, '<leader>5', '<cmd>:BufferGoto 5<cr>', {noremap = true})
  map({'n', 'x'}, '<leader>6', '<cmd>:BufferGoto 6<cr>', {noremap = true})
  map({'n', 'x'}, '<leader>7', '<cmd>:BufferGoto 7<cr>', {noremap = true})
  map({'n', 'x'}, '<leader>8', '<cmd>:BufferGoto 8<cr>', {noremap = true})
  map({'n', 'x'}, '<leader>9', '<cmd>:BufferLast<cr>', {noremap = true})
  map({'n', 'x'}, '<leader>tx', '<cmd>:BufferClose<cr>', {silent = true, noremap = true})
end

return tabline
