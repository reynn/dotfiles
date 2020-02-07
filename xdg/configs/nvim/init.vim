" =============================================================================
" General Vim Configuration
" =============================================================================

set nocompatible
filetype off
set rtp+="~/.vim/scripts/"
let mapleader = ","

if has('nvim')
  set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
  set inccommand=nosplit
  noremap <C-q> :confirm qall<CR>
end

" deal with colors
if !has('gui_running')
  set t_Co=256
endif
if (match($TERM, "-256color") != -1) && (match($TERM, "screen-256color") == -1)
  " screen does not (yet) support truecolor
  set termguicolors
endif
" Colors
set background=dark
hi Normal ctermbg=NONE
" Get syntax
syntax on

let g:python3_host_prog = expand("~/.xdg/data/virtualenvs/nvim-*/bin/python")

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

filetype plugin indent on
set autoindent
set timeoutlen=500 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set scrolloff=2
set noshowmode
set hidden
set nowrap
set nojoinspaces
set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter
set signcolumn=no
set shell=zsh

" Settings needed for .lvimrc
set exrc
set secure

" Sane splits
set splitright
set splitbelow

" Permanent undo
set undodir=~/.vimdid
set undofile

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" Set tab widths
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" =============================================================================
" # GUI settings
" =============================================================================

set guioptions-=T " Remove toolbar
set vb t_vb=      " No more beeps
set backspace=2   " Backspace over newlines
set ruler         " Where am I?
set nofoldenable
set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw
set synmaxcol=500
set laststatus=2
set relativenumber  " Relative line numbers
set number          " Also show current absolute line
set diffopt+=iwhite " No whitespace in vimdiff
                    " Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
set showcmd      " Show (partial) command in status line.
set mouse=a      " Enable mouse usage (all modes) in terminals
set shortmess+=c " don't give |ins-completion-menu| messages.

" Show those damn hidden characters
" Verbose: set listchars=nbsp:¬,eol:¶,extends:»,precedes:«,trail:•
set nolist
set listchars=nbsp:¬,extends:»,precedes:«,trail:•

" Don't confirm .lvimrc
let g:localvimrc_ask = 0

" =============================================================================
" # Plugins
" =============================================================================

call plug#begin("~/.vim/plugged")

" Plugins: General Enhancements

Plug 'ciaranm/securemodelines'        " Secure, user-configurable modeline support for Vim
Plug 'editorconfig/editorconfig-vim'  " Have VIM adhere to .editorconfig files
Plug 'mg979/vim-visual-multi'         " Multi line select, easily find recurring text
Plug 'tpope/vim-fugitive'             " Extensive Git integration added to Vim

" Plugins: Formatters

Plug 'godlygeek/tabular'              " Formatter that allows alignment by any character

" Plugins: GUI enhancements

Plug 'itchyny/lightline.vim'          " Adds a powerline like status bar at the bottom
Plug 'machakann/vim-highlightedyank'  " Highlights line after y is pressed
Plug 'andymass/vim-matchup'           " Highlight, navigate and operate on sets of matching text
Plug 'preservim/nerdtree'             " File Explorer tab
Plug 'Xuyuanp/nerdtree-git-plugin'    " Add git information to NerdTree
Plug 'airblade/vim-gitgutter'         " Show git changes in margin of file buffer
Plug 'frazrepo/vim-rainbow'           " Colorize tabs, parens to make them easier to see

" Plugins: Themes/Color Schemes

Plug 'flrnprz/candid.vim'             " Additional dark color scheme
Plug 'rafi/awesome-vim-colorschemes'  " Large pack of colorschemes

" Plugins: Snippets

Plug 'SirVer/ultisnips'               " Language agnostic snippets

" Plugins: Fuzzy finder

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Fuzzy finding inside Vim/NVim
Plug 'junegunn/fzf.vim'                                           " Additional Vim setup for FZF

" Plugins: Semantic language support

Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense for Vim, uses language servers like VSCode

" Plugins: Syntactic language support

Plug 'plasticboy/vim-markdown'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'
Plug 'elzr/vim-json'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()

" Plugin Config: ciaranm/securemodelines

let g:secure_modelines_allowed_items = [
  \ "textwidth",   "tw",
  \ "softtabstop", "sts",
  \ "tabstop",     "ts",
  \ "shiftwidth",  "sw",
  \ "expandtab",   "et",   "noexpandtab", "noet",
  \ "filetype",    "ft",
  \ "foldmethod",  "fdm",
  \ "readonly",    "ro",   "noreadonly", "noro",
  \ "rightleft",   "rl",   "norightleft", "norl",
  \ "colorcolumn"
\ ]

" Plugin Config: editorconfig/editorconfig-vim


" Plugin Config: mg979/vim-visual-multi

let g:VM_leader = ",,"
let g:VM_mouse_mappings = 1

nmap <S-LeftMouse>    <Plug>(VM-Mouse-Cursor)
nmap <C-RightMouse>   <Plug>(VM-Mouse-Word)
nmap <M-S-LeftMouse> <Plug>(VM-Mouse-Column)

" Plugin Config: godlygeek/tabular

if exists(":Tabularize")
  nmap <leader>t= :Tabularize /=<CR>
  vmap <leader>t= :Tabularize /=<CR>
  nmap <leader>t: :Tabularize /:\zs<CR>
  vmap <leader>t: :Tabularize /:\zs<CR>
endif

" Plugin Config: itchyny/lightline.vim

let g:lightline = {
  \ 'colorscheme': 'seoul256',
  \ 'component_function': {
  \   'filename': 'LightlineFilename',
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ 'active': {
  \   'left': [
  \     ['mode'],
  \     ['filename', 'modified']
  \   ],
  \   'right': [
  \     ['lineinfo'],
  \     ['gitbranch', 'fileencoding', 'filetype']
  \   ]
  \ }
\ }

" Plugin Config: machakann/vim-highlightedyank

let g:highlightedyank_highlight_duration = 500

" Plugin Config: andymass/vim-matchup

let g:matchup_enabled = 1
let g:matchup_surround_enabled = 1

" Plugin Config: preservim/nerdtree

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <leader>n :NERDTreeFocus<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

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

" Plugin Config: airblade/vim-gitgutter

let g:gitgutter_max_signs = 800

" Plugin Config: frazrepo/vim-rainbow

let g:rainbow_active = 1

" Plugin Config: SirVer/ultisnips

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"

" Plugin Config: junegunn/fzf

let g:fzf_layout = { 'down': '~40%' }

" Plugin Config: neoclide/coc.nvim

command! -nargs=0 Prettier :CocCommand prettier.formatFile

map <leader>f :Prettier<CR>
nmap <silent> E <Plug>(coc-diagnostic-prev)
nmap <silent> W <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" Plugin Config: plasticboy/vim-markdown

let g:vim_markdown_autowrite = 1
let g:vim_markdown_no_extensions_in_markdown = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_auto_insert_bullets = 1
map <leader>tf :TableFormat<cr>

" Plugin Config: fatih/vim-go

let g:go_addtags_transform = 'snakecase'
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:go_bin_path = expand("~/go/bin")
let g:go_doc_max_height = 40
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_info_mode = 'gopls'
let g:go_mod_fmt_autosave = 1
let g:go_play_open_browser = 0
let g:go_snippet_engine = "ultisnips"
let g:go_template_file = expand("~/.xdg/config/nvim/_go.go")
let g:go_template_test_file = expand("~/.xdg/config/nvim/_go_test.go")
let g:go_updatetime = 300

let g:go_fmt_options = {
  \ 'gofmt': '-s',
  \ 'goimports': '-local github.concur.com',
  \ }

" =============================================================================
" # Color scheme settings
" =============================================================================

colorscheme parsec

" =============================================================================
" # Custom Functions
" =============================================================================

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! LightlineFilename()
  return &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &filetype ==# 'unite' ? unite#get_status_string() :
        \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
endfunction

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction

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
nnoremap ; :

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
noremap M :!make -k -j8<cr>

map <leader>F :Files<CR>
nmap <leader>B :Buffers<CR>
nmap <leader>W :Windows<CR>

" Quick-save
nmap <leader>w :w<CR>

" =============================================================================
" # Autocommands
" =============================================================================

" Prevent accidental writes to buffers that shouldn't be edited
autocmd BufRead *.orig set readonly
autocmd BufRead *.pacnew set readonly

" Leave paste mode when leaving insert mode
autocmd InsertLeave * set nopaste
" Leaving insert mode will save the file as well
autocmd InsertLeave * :w

" Jump to last edit position on opening file
if has("autocmd")
  " https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
  au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
" Help filetype detection
autocmd BufRead *.go set filetype=go
autocmd BufRead *.plot set filetype=gnuplot
autocmd BufRead *.md set filetype=markdown
autocmd BufRead *.lds set filetype=ld
autocmd BufRead *.tex set filetype=tex
autocmd BufRead *.trm set filetype=c
autocmd BufRead *.xlsx.axlsx set filetype=ruby

if has ('autocmd') " Remain compatible with earlier versions
 augroup vimrc     " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd

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
autocmd Filetype html,xml,xsl,php source $XDG_CONFIG_HOME/nvim/scripts/closetag.vim

" =============================================================================
" # Footer
" =============================================================================

" nvim
if has('nvim')
  runtime! plugin/python_setup.vim
endif
