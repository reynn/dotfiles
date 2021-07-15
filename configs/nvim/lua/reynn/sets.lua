local utils = require('reynn.utils')
local opt = utils.opt

opt('background', 'dark') --
opt('concealcursor', 'nc', window) --
opt('conceallevel', 2, window) --
opt('cursorline', true, window) --
opt('display', 'msgsep') --
opt('expandtab', true, buffer) --
opt('hidden', true) --
opt('ignorecase', true) --
opt('inccommand', 'nosplit') --
opt('laststatus', 2) --
opt('lazyredraw', true) --
opt('modeline', false, buffer) --
opt('mouse', 'nivh') --
opt('number', true, window) --
opt('previewheight', 5) --
opt('relativenumber', true, window) --
opt('scrolloff', 10) --
opt('shiftwidth', 2, buffer) --
opt('showmatch', true) --
opt('signcolumn', 'yes', window) --
opt('smartcase', true) --
opt('smartindent', true, buffer) --
opt('softtabstop', 0, buffer) --
opt('synmaxcol', 500, buffer) --
opt('tabstop', 2, buffer) --
opt('termguicolors', true) --
opt('textwidth', 120, buffer) --
opt('undofile', true, buffer) --
opt('updatetime', 300) --
opt('foldmethod', 'expr') --
opt('foldexpr', 'nvim_treesitter#foldexpr()') --
