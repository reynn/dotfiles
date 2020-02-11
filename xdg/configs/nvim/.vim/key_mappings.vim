" =============================================================================
" # Key mappings
" =============================================================================

" <CR> Execute Previous command
" <C-X> Ctrl + X
" <C-R>= Result of a Vim expression in insert mode
" | Commands               | Mode                    |
" | ---------------------- | ----------------------- |
" | nmap, nnoremap, nunmap | Normal mode             |
" | imap, inoremap, iunmap | Insert and Replace mode |
" | vmap, vnoremap, vunmap | Visual and Select mode  |
" | xmap, xnoremap, xunmap | Visual mode             |
" | smap, snoremap, sunmap | Select mode             |
" | cmap, cnoremap, cunmap | Command-line mode       |
" | omap, onoremap, ounmap | Operator pending mode   |

" | Vim Binding   | Meaning                                                       |
" | ------------- | ------------------------------------------------------------- |
" | <A-X>, <M-X>  | Alt                                                           |
" | <C-X>         | Ctrl                                                          |
" | <S-X>         | Shift                                                         |
" | <C-S-X>       | Ctrl+Shift                                                    |
" | <D-X>         | Super (Windows Key)                                           |
" | <BS>          | Backspace                                                     |
" | <Tab>         | Tab                                                           |
" | <CR>          | Enter                                                         |
" | <Enter>       | Enter                                                         |
" | <Return>      | Enter                                                         |
" | <Esc>         | Escape                                                        |
" | <Space>       | Space                                                         |
" | <Up>          | Up arrow                                                      |
" | <Down>        | Down arrow                                                    |
" | <Left>        | Left arrow                                                    |
" | <Right>       | Right arrow                                                   |
" | <F1> - <F12>  | Function keys 1 to 12                                         |
" | #1, #2..#9,#0 | Function keys F1 to F9, F10                                   |
" | <Insert>      | Insert                                                        |
" | <Del>         | Delete                                                        |
" | <Home>        | Home                                                          |
" | <End>         | End                                                           |
" | <PageUp>      | Page-Up                                                       |
" | <PageDown>    | Page-Down                                                     |
" | <bar>         | the '|' character, which otherwise needs to be escaped '\ | ' |

" ; as :
"nnoremap ; :

" Ctrl+c and Ctrl+j as Esc
" Ctrl-j is a little awkward unfortunately:
" https://github.com/neovim/neovim/issues/5916
" So we also map Ctrl+k
inoremap <C-j> <Esc>

nnoremap <C-k> <Esc>
inoremap <C-k> <Esc>
vnoremap <C-k> <Esc>
snoremap <C-k> <Esc>
xnoremap <C-k> <Esc>
cnoremap <C-k> <Esc>
onoremap <C-k> <Esc>
lnoremap <C-k> <Esc>
tnoremap <C-k> <Esc>

nnoremap <C-c> <Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>
snoremap <C-c> <Esc>
xnoremap <C-c> <Esc>
cnoremap <C-c> <Esc>
onoremap <C-c> <Esc>
lnoremap <C-c> <Esc>
tnoremap <C-c> <Esc>

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Neat X clipboard integration
" ,p will paste clipboard into buffer
noremap <leader>p :read !pbpaste<cr>
" ,c will copy entire buffer into clipboard
noremap <leader>c :w !pbcopy<cr><cr>

" <leader>s for Rg search
noremap <leader>s :Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" t+left/right to switch between VIM tabs
nnoremap t<left> :tabprevious<CR>
nnoremap t<right> :tabnext<CR>
" b+left/right to switch between VIM buffers
nnoremap b<left> :bp<CR>
nnoremap b<right> :bn<CR>
" w+left/right to switch between VIM windows
nnoremap w<left> :wprevious<CR>
nnoremap w<right> :wNext<CR>

" Quick mapping to edit init.vim file
nnoremap <leader>ev :split $MYVIMRC<CR>

" Move by line
nnoremap j gj
nnoremap k gk

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" <leader>, shows/hides hidden characters
nnoremap <leader>i :set invlist<cr>

" <leader>q shows stats
nnoremap <leader>q g<c-g>

" M to make
noremap M :!mage<cr>

map <leader>F :Files<CR>
nmap <leader>B :Buffers<CR>
nmap <leader>W :Windows<CR>

" Quick-save
nmap <leader>w :w<CR>
