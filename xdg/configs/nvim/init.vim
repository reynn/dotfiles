" =============================================================================
" General Vim Configuration
" =============================================================================

set nocompatible
filetype off
set rtp+="~/scripts/"
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

let g:python3_host_prog = expand("$XDG_DATA_HOME/virtualenvs/nvim-*/bin/python")

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
set fixendofline
set noshowmode
set hidden
set nowrap
set nojoinspaces
set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter
set signcolumn=no
set shell=zsh
set showtabline=2
set guioptions-=e

" Settings needed for .lvimrc
set exrc
set secure

" Sane splits
set splitright
set splitbelow

" Permanent undo
set undodir=~/.vim/did
set undofile

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
" set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

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
set fixendofline
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

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/plugin/_list.vim'

" =============================================================================
" # Custom Functions
" =============================================================================

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/functions.vim'

" =============================================================================
" # Key mappings
" =============================================================================

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/mappings.vim'

" =============================================================================
" # Special language handling
" =============================================================================

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/languages.vim'
