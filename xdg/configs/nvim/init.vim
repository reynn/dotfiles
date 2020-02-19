" =============================================================================
" General Vim Configuration
" =============================================================================

filetype off

set background=dark
set guicursor=n-v-c:block-Cursor/lCursor-blinkon0,i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
set inccommand=nosplit
set nocompatible
set rtp+="~/scripts/"
set t_Co=256
set termguicolors

let mapleader=","

noremap <C-q> :confirm qall<CR>

" Colors
hi Normal ctermbg=NONE

" Get syntax
syntax on

let g:python3_host_prog=expand("$XDG_DATA_HOME/virtualenvs/nvim-*/bin/python")

" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('rg')
  set grepprg=rg\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

filetype plugin indent on
set autoindent
set encoding=utf-8
set guioptions-=e
set hidden
set noendofline
set nojoinspaces
set noshowmode
set nowrap
set printencoding=utf-8
set printfont=:h10
set printoptions=paper:letter
set scrolloff=5
set shell=zsh
set showtabline=2
set signcolumn=yes
set timeoutlen=350 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line

" Settings needed for .lvimrc
set noexrc
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
set noexpandtab

" Wrapping options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing ENTER in I mode
set formatoptions+=q " enable formatting of comments with gq
set formatoptions+=n " detect lists for formatting
" set formatoptions+=b " auto-wrap in insert mode, and do not wrap old long lines

" Proper search
set hlsearch
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
set foldenable
set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set nolazyredraw
set synmaxcol=200   " Syntax highlight the first n characters
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
set list
set listchars=nbsp:¬,extends:»,precedes:«,trail:•,tab:>-

" Don't confirm .lvimrc
let g:localvimrc_ask=0

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

colorscheme gruvbox
