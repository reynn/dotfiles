" =============================================================================
" Plugins
" =============================================================================

call plug#begin("~/.vim/plugged")

" Plugins: General Enhancements

Plug 'https://github.com/ciaranm/securemodelines'                                        " Secure, user-configurable modeline support for Vim
Plug 'https://github.com/editorconfig/editorconfig-vim'                                  " Have VIM adhere to .editorconfig files
Plug 'https://github.com/mg979/vim-visual-multi'                                         " Multi line select, easily find recurring text
Plug 'https://github.com/tpope/vim-fugitive'                                             " Extensive Git integration added to Vim
Plug 'https://github.com/victorhge/iedit'                                                " Multi cursor editing.

" Plugins: Formatters

Plug 'https://github.com/godlygeek/tabular'                                              " Formatter that allows alignment by any character

" Plugins: GUI enhancements

Plug 'https://github.com/itchyny/lightline.vim'                                          " Adds a powerline like status bar at the bottom
Plug 'https://github.com/machakann/vim-highlightedyank'                                  " Highlights line after y is pressed
Plug 'https://github.com/andymass/vim-matchup'                                           " Highlight, navigate and operate on sets of matching text
Plug 'https://github.com/preservim/nerdtree'                                             " File Explorer tab
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin'                                    " Add git information to NerdTree
Plug 'https://github.com/airblade/vim-gitgutter'                                         " Show git changes in margin of file buffer
Plug 'https://github.com/frazrepo/vim-rainbow'                                           " Colorize tabs, parens to make them easier to see

" Plugins: Themes/Color Schemes

Plug 'https://github.com/morhetz/gruvbox'                                                " Customizable Dark theme

" Plugins: Snippets
" Replaced by a CoC extension
"Plug 'https://github.com/SirVer/ultisnips'                                              " Language agnostic snippets

" Plugins: Fuzzy finder

Plug 'https://github.com/junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }     " Fuzzy finding inside Vim/NVim
Plug 'https://github.com/junegunn/fzf.vim'                                               " Additional Vim setup for FZF

" Plugins: Semantic language support

Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}                       " Intellisense for Vim, uses language servers like VSCode

" Plugins: Syntactic language support

Plug 'https://github.com/fatih/vim-go', { 'for': 'go','do': ':GoUpdateBinaries' }
Plug 'https://github.com/python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

call plug#end()
