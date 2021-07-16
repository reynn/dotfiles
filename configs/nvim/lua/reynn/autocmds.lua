local utils = require('reynn.utils')
local autocmd = utils.autocmd

-- autocmd('start_screen', [[VimEnter * ++once lua require('reynn.start').show()]], true)
autocmd('syntax_aucmds',
  [[Syntax * syn match extTodo "\<\(NOTE\|HACK\|BAD\|TODO\):\?" containedin=.*Comment.* | hi! link extTodo Todo]],
  true)
autocmd('misc_aucmds', { [[BufWinEnter * checktime]], [[TextYankPost * silent! lua vim.highlight.on_yank()]] }, true)
