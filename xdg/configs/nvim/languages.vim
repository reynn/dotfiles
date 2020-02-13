" =============================================================================
" # Special language handling
" =============================================================================

" Set tabs to 4 characters when that is the suggested format style
let fts = ['go']
if index(fts, &filetype) == -1
  set shiftwidth=4
  set softtabstop=4
  set tabstop=4
  set noexpandtab
endif

" Script plugins
autocmd Filetype html,xml,xsl,php source expand('$XDG_CONFIG_HOME/nvim/scripts/closetag.vim')
