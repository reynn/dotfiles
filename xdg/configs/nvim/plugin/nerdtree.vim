" Plugin Config: preservim/nerdtree

" use leader+n as the way to trigger nerdtree
map <leader>n :NERDTreeFocus<CR>

" calls NERDTreeFind iff NERDTree is active, current window contains a modifiable file, and we're not in vimdiff
function! s:syncTree()
  let s:curwnum = winnr()
  NERDTreeFind
  exec s:curwnum . "wincmd w"
endfunction

function! s:syncTreeIf()
  if (winnr("$") > 1)
    call s:syncTree()
  endif
endfunction

" Shows NERDTree on start and synchronizes the tree with opened file when switching between opened windows
" autocmd BufEnter * call s:syncTreeIf()

" Focus on opened view after starting (instead of NERDTree)
" autocmd VimEnter * call s:syncTree()

" Open nerdtree at startup if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Prevent Tab on NERDTree (breaks everything otherwise)
autocmd FileType nerdtree noremap <buffer> <Tab> <nop>

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
