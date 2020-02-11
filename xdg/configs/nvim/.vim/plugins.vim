" =============================================================================
" # Plugins
" =============================================================================

call plug#begin("~/.vim/plugged")

" Plugins: General Enhancements

Plug 'ciaranm/securemodelines'                                        " Secure, user-configurable modeline support for Vim
Plug 'editorconfig/editorconfig-vim'                                  " Have VIM adhere to .editorconfig files
Plug 'mg979/vim-visual-multi'                                         " Multi line select, easily find recurring text
Plug 'tpope/vim-fugitive'                                             " Extensive Git integration added to Vim
Plug 'victorhge/iedit'                                                " Multi cursor editing.

" Plugins: Formatters

Plug 'godlygeek/tabular'                                              " Formatter that allows alignment by any character

" Plugins: GUI enhancements

Plug 'itchyny/lightline.vim'                                          " Adds a powerline like status bar at the bottom
Plug 'machakann/vim-highlightedyank'                                  " Highlights line after y is pressed
Plug 'andymass/vim-matchup'                                           " Highlight, navigate and operate on sets of matching text
Plug 'preservim/nerdtree'                                             " File Explorer tab
Plug 'Xuyuanp/nerdtree-git-plugin'                                    " Add git information to NerdTree
Plug 'airblade/vim-gitgutter'                                         " Show git changes in margin of file buffer
Plug 'frazrepo/vim-rainbow'                                           " Colorize tabs, parens to make them easier to see

" Plugins: Themes/Color Schemes

Plug 'morhetz/gruvbox'                                                " Customizable Dark theme

" Plugins: Snippets

Plug 'SirVer/ultisnips'                                               " Language agnostic snippets

" Plugins: Fuzzy finder

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }     " Fuzzy finding inside Vim/NVim
Plug 'junegunn/fzf.vim'                                               " Additional Vim setup for FZF

" Plugins: Semantic language support

Plug 'neoclide/coc.nvim', {'branch': 'release'}                       " Intellisense for Vim, uses language servers like VSCode

" Plugins: Syntactic language support

Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'fatih/vim-go', { 'for': 'go','do': ':GoUpdateBinaries' }
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

call plug#end()
