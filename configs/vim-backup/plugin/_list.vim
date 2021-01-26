" =============================================================================
" Plugins
" =============================================================================

call plug#begin("~/.vim/plugged")

" Plugins: General Enhancements

Plug 'https://github.com/AndrewRadev/splitjoin.vim'               " Switch between a single-line code statement and a multi-line one
Plug 'https://github.com/Raimondi/delimitMate'                    " automatic closing of quotes, parenthesis, brackets, etc.
Plug 'https://github.com/chrisbra/Recover.vim'                    " Show a diff of the swap file before loading
Plug 'https://github.com/ciaranm/securemodelines'                 " Secure, user-configurable modeline support for Vim
Plug 'https://github.com/ctrlpvim/ctrlp.vim'                      " Fuzzy finding of files, buffers and more
Plug 'https://github.com/dhruvasagar/vim-table-mode'              " Convert text block to a table
Plug 'https://github.com/easymotion/vim-easymotion'               " Simplify movement in vim
Plug 'https://github.com/editorconfig/editorconfig-vim'           " Use of .editorconfig files to set indentation etc
Plug 'https://github.com/honza/vim-snippets'                      " Contains a bunch of pre-configured snippets
Plug 'https://github.com/junegunn/vim-easy-align'                 " Handle aligning text
Plug 'https://github.com/mbbill/undotree'                         " Show a branching history of undo/redo
Plug 'https://github.com/mg979/vim-visual-multi'                  " Multi line select, easily find recurring text
Plug 'https://github.com/mhinz/vim-sayonara'                      " Deletes the buffer and handles windows more intelligently
Plug 'https://github.com/tpope/vim-fugitive'                      " Extensive Git integration added to Vim
Plug 'https://github.com/tpope/vim-repeat'                        " Beef up the default . repeater
Plug 'https://github.com/tpope/vim-rhubarb'                       " Add fancy extras for GitHub to the vim-fugitive plugin
Plug 'https://github.com/liuchengxu/vim-which-key'                " Keybinding manager

" Plugins: Session Enhancements

Plug 'https://github.com/xolox/vim-misc'                          " Miscellaneous auto-load Vim scripts
Plug 'https://github.com/xolox/vim-session'                       " Extended session management for Vim

" Plugins: Text Objects/Motions/Editing

Plug 'https://github.com/bkad/CamelCaseMotion'                    " Move through camel case words (<leader>w, <leader>b)
Plug 'https://github.com/kana/vim-textobj-user'                   " Allow users to define their own text objects
Plug 'https://github.com/michaeljsmith/vim-indent-object'         " Select text object based on indentation level (ii, ai, 3ai)
Plug 'https://github.com/tpope/vim-commentary'                    " Quickly comment out lines (gcc, gcap, vis:gc)
Plug 'https://github.com/tpope/vim-surround'                      " Surround text with characters (ysiw], vis:ys, yssb)
Plug 'https://github.com/vim-scripts/argtextobj.vim'              " Adds function argument text object (daa, via, cia)

" Plugins: GUI enhancements

Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin'             " Add git information to NerdTree
Plug 'https://github.com/airblade/vim-gitgutter'                  " Show git changes in margin of file buffer
Plug 'https://github.com/andymass/vim-matchup'                    " Highlight, navigate and operate on sets of matching text
Plug 'https://github.com/frazrepo/vim-rainbow'                    " Colorize tabs, parens to make them easier to see
Plug 'https://github.com/itchyny/lightline.vim'                   " Adds a powerline like status bar at the bottom
Plug 'https://github.com/machakann/vim-highlightedyank'           " Highlights line after y is pressed
Plug 'https://github.com/noscripter/tabman.vim'                   " Simple management of tabs in Vim
Plug 'https://github.com/preservim/nerdtree'                      " File Explorer tab

" Plugins: Themes/Color Schemes

Plug 'https://github.com/NLKNguyen/papercolor-theme'              " Light theme
Plug 'https://github.com/morhetz/gruvbox'                         " Configurable dark mode theme
Plug 'https://github.com/dracula/vim'                             " Configurable dark mode theme

" Plugins: Fuzzy finder

Plug 'https://github.com/junegunn/fzf', {
  \'dir'    : '~/.fzf',
  \'do'     : './install --bin'
\}                                                                " Fuzzy finding inside Vim/NVim
Plug 'https://github.com/junegunn/fzf.vim'                        " Additional Vim setup for FZF

" Plugins: Language support

Plug 'https://github.com/cespare/vim-toml'                        " Add support for TOML files
Plug 'https://github.com/iamcco/markdown-preview.vim'             " A preview of how your Markdown will render
Plug 'https://github.com/OmniSharp/omnisharp-vim'                 " dotnet support
Plug 'https://github.com/pearofducks/ansible-vim'                 " Ansible goodies
Plug 'https://github.com/fatih/vim-go', {
  \'for'    : 'go',
  \'do'     : ':GoUpdateBinaries'
\}                                                                " Lots of goodies for writing Golang code
Plug 'https://github.com/hashivim/vim-packer'                     " Add support for Hashicorp Packer
Plug 'https://github.com/hashivim/vim-terraform'                  " Add support for Hashicorp Terraform
Plug 'https://github.com/mzlogin/vim-markdown-toc'                " Manage ToC sections for Markdown files
Plug 'https://github.com/neoclide/coc.nvim', {
  \'do'     : 'yarn install --frozen-lockfile'
\}                                                                " Intellisense for Vim, uses language servers like VSCode
Plug 'https://github.com/python-mode/python-mode', {
  \'for'    : 'python',
  \'branch' : 'develop'
\}                                                                " Goodies for writing Python code
Plug 'https://github.com/raimon49/requirements.txt.vim', {
  \'for'    : 'requirements'
\}                                                                " Add support for Python requirements files

" This is at the bottom to ensure it loads after any other plugins that may
" use it
Plug 'https://github.com/ryanoasis/vim-devicons'                  " Icons for various filetypes
Plug 'https://github.com/tiagofumo/vim-nerdtree-syntax-highlight' " Highlight nerdtree based on filtype

call plug#end()