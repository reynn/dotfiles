" Plugin Config: preservim/nerdtree

" use leader+n as the way to trigger nerdtree
map <leader>n :NERDTreeToggle<CR>

" Open nerdtree at startup if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" When a file is deleted in NERDTree automatically delete the buffer
let NERDTreeAutoDeleteBuffer=1
" Don't show the help text
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1
" Default to showing hidden files instead of having to hit I
let NERDTreeShowHidden=1

" Plugin Config: Xuyuanp/nerdtree-git-plugin

let g:NERDTreeIndicatorMapCustom = {
  \ "Modified"  : "✹",
  \ "Staged"    : "✚",
  \ "Untracked" : "✭",
  \ "Renamed"   : "➜",
  \ "Unmerged"  : "═",
  \ "Deleted"   : "✖",
  \ "Dirty"     : "✗",
  \ "Clean"     : "✔︎",
  \ 'Ignored'   : '☒',
  \ "Unknown"   : "?"
\ }
