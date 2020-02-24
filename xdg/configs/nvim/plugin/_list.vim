" =============================================================================
" Plugins
" =============================================================================

call plug#begin("~/.vim/plugged")

" Plugins: General Enhancements

Plug 'https://github.com/AndrewRadev/splitjoin.vim'     " Switch between a single-line code statement and a multi-line one
Plug 'https://github.com/Raimondi/delimitMate'          " automatic closing of quotes, parenthesis, brackets, etc.
Plug 'https://github.com/ciaranm/securemodelines'       " Secure, user-configurable modeline support for Vim
Plug 'https://github.com/easymotion/vim-easymotion'     " Simplify movement in vim
Plug 'https://github.com/honza/vim-snippets'            " Contains a bunch of pre-configured snippets
Plug 'https://github.com/junegunn/vim-easy-align'       " Handle aligning text
Plug 'https://github.com/dhruvasagar/vim-table-mode'    " Convert text block to a table
Plug 'https://github.com/mg979/vim-visual-multi'        " Multi line select, easily find recurring text
Plug 'https://github.com/mhinz/vim-sayonara'            " Deletes the buffer and handles windows more intelligently
Plug 'https://github.com/tpope/vim-commentary'          " Quickly comment out lines (gcc, gcap, vis:gc)
Plug 'https://github.com/tpope/vim-fugitive'            " Extensive Git integration added to Vim
Plug 'https://github.com/tpope/vim-rhubarb'             " Add fancy extras for GitHub to the vim-fugitive plugin
Plug 'https://github.com/tpope/vim-surround'            " Surround text with characters (ysiw], vis:ys, yssb)
Plug 'https://github.com/ctrlpvim/ctrlp.vim'            " Fuzzy finding of files, buffers and more
Plug 'https://github.com/mbbill/undotree'               " Show a branching history of undo/redo

" Plugins: GUI enhancements

Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin'   " Add git information to NerdTree
Plug 'https://github.com/airblade/vim-gitgutter'        " Show git changes in margin of file buffer
Plug 'https://github.com/andymass/vim-matchup'          " Highlight, navigate and operate on sets of matching text
Plug 'https://github.com/frazrepo/vim-rainbow'          " Colorize tabs, parens to make them easier to see
Plug 'https://github.com/itchyny/lightline.vim'         " Adds a powerline like status bar at the bottom
Plug 'https://github.com/junegunn/goyo.vim'             " Hide much of the UI to allow less distractions
Plug 'https://github.com/machakann/vim-highlightedyank' " Highlights line after y is pressed
Plug 'https://github.com/noscripter/tabman.vim'         " Simple management of tabs in Vim
Plug 'https://github.com/preservim/nerdtree'            " File Explorer tab

" Plugins: Themes/Color Schemes

Plug 'https://github.com/NLKNguyen/papercolor-theme'    " Light theme
Plug 'https://github.com/morhetz/gruvbox'               " Configurable dark mode theme

" Plugins: Fuzzy finder

Plug 'https://github.com/junegunn/fzf', {
  \'dir': '~/.fzf',
  \'do': './install --all'
\}                                                      " Fuzzy finding inside Vim/NVim
Plug 'https://github.com/junegunn/fzf.vim'              " Additional Vim setup for FZF

" Plugins: Language support

Plug 'https://github.com/pearofducks/ansible-vim'       " Ansible goodies
Plug 'https://github.com/fatih/vim-go', {
  \'for': 'go',
  \'do': ':GoUpdateBinaries'
\}                                                      " Lots of goodies for writing Golang code
Plug 'https://github.com/hashivim/vim-packer'           " Add support for Hashicorp Packer
Plug 'https://github.com/hashivim/vim-terraform'        " Add support for Hashicorp Terraform
Plug 'https://github.com/mzlogin/vim-markdown-toc'      " Manage ToC sections for Markdown files
Plug 'https://github.com/neoclide/coc.nvim', {
  \'do': 'yarn install --frozen-lockfile'
\}                                                      " Intellisense for Vim, uses language servers like VSCode
Plug 'https://github.com/python-mode/python-mode', {
  \'for':    'python',
  \'branch': 'develop'
\}                                                      " Goodies for writing Python code
Plug 'https://github.com/raimon49/requirements.txt.vim', {
  \'for': 'requirements'
\}                                                      " Add support for Python requirements files

call plug#end()
