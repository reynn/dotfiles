" =============================================================================
" Plugins
" =============================================================================

call plug#begin("~/.vim/plugged")

" Plugins: General Enhancements

Plug 'AndrewRadev/splitjoin.vim'               " Switch between a single-line code statement and a multi-line one
Plug 'Raimondi/delimitMate'                    " automatic closing of quotes, parenthesis, brackets, etc.
Plug 'chrisbra/Recover.vim'                    " Show a diff of the swap file before loading
Plug 'ciaranm/securemodelines'                 " Secure, user-configurable modeline support for Vim
Plug 'ctrlpvim/ctrlp.vim'                      " Fuzzy finding of files, buffers and more
Plug 'dhruvasagar/vim-table-mode'              " Convert text block to a table
Plug 'easymotion/vim-easymotion'               " Simplify movement in vim
Plug 'editorconfig/editorconfig-vim'           " Use of .editorconfig files to set indentation etc
Plug 'honza/vim-snippets'                      " Contains a bunch of pre-configured snippets
Plug 'junegunn/vim-easy-align'                 " Handle aligning text
Plug 'mbbill/undotree'                         " Show a branching history of undo/redo
Plug 'mg979/vim-visual-multi'                  " Multi line select, easily find recurring text
Plug 'mhinz/vim-sayonara'                      " Deletes the buffer and handles windows more intelligently
Plug 'tpope/vim-fugitive'                      " Extensive Git integration added to Vim
Plug 'tpope/vim-repeat'                        " Beef up the default . repeater
Plug 'tpope/vim-rhubarb'                       " Add fancy extras for GitHub to the vim-fugitive plugin
Plug 'liuchengxu/vim-which-key'                " Keybinding manager
Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Highlight NerdTree based on filetype

" Plugins: Session Enhancements

Plug 'xolox/vim-misc'                          " Miscellaneous auto-load Vim scripts
Plug 'xolox/vim-session'                       " Extended session management for Vim

" Plugins: Text Objects/Motions/Editing

Plug 'bkad/CamelCaseMotion'                    " Move through camel case words (<leader>w, <leader>b)
Plug 'kana/vim-textobj-user'                   " Allow users to define their own text objects
Plug 'michaeljsmith/vim-indent-object'         " Select text object based on indentation level (ii, ai, 3ai)
Plug 'tpope/vim-commentary'                    " Quickly comment out lines (gcc, gcap, vis:gc)
Plug 'tpope/vim-surround'                      " Surround text with characters (ysiw], vis:ys, yssb)
Plug 'vim-scripts/argtextobj.vim'              " Adds function argument text object (daa, via, cia)

" Plugins: GUI enhancements

Plug 'Xuyuanp/nerdtree-git-plugin'             " Add git information to NerdTree
Plug 'airblade/vim-gitgutter'                  " Show git changes in margin of file buffer
Plug 'andymass/vim-matchup'                    " Highlight, navigate and operate on sets of matching text
Plug 'frazrepo/vim-rainbow'                    " Colorize tabs, parens to make them easier to see
Plug 'itchyny/lightline.vim'                   " Adds a powerline like status bar at the bottom
Plug 'machakann/vim-highlightedyank'           " Highlights line after y is pressed
Plug 'noscripter/tabman.vim'                   " Simple management of tabs in Vim
Plug 'preservim/nerdtree'                      " File Explorer tab

" Plugins: Themes/Color Schemes

Plug 'NLKNguyen/papercolor-theme'              " Light theme
Plug 'morhetz/gruvbox'                         " Configurable dark mode theme

" Plugins: Fuzzy finder

Plug 'junegunn/fzf', {
  \'dir'    : '~/.fzf',
  \'do'     : './install --bin'
\}                                             " Fuzzy finding inside Vim/NVim
Plug 'junegunn/fzf.vim'                        " Additional Vim setup for FZF

" Plugins: Language support

Plug 'https://github.com/cespare/vim-toml'     " Add support for TOML files
Plug 'iamcco/markdown-preview.vim'             " A preview of how your Markdown will render
Plug 'OmniSharp/omnisharp-vim'                 " dotnet support
Plug 'pearofducks/ansible-vim'                 " Ansible goodies
Plug 'fatih/vim-go', {
  \'for'    : 'go',
  \'do'     : ':GoUpdateBinaries'
\}                                             " Lots of goodies for writing Golang code
Plug 'hashivim/vim-packer'                     " Add support for Hashicorp Packer
Plug 'hashivim/vim-terraform'                  " Add support for Hashicorp Terraform
Plug 'mzlogin/vim-markdown-toc'                " Manage ToC sections for Markdown files
Plug 'neoclide/coc.nvim', {
  \'do'     : 'yarn install --frozen-lockfile'
\}                                             " Intellisense for Vim, uses language servers like VSCode
Plug 'python-mode/python-mode', {
  \'for'    : 'python',
  \'branch' : 'develop'
\}                                             " Goodies for writing Python code
Plug 'raimon49/requirements.txt.vim', {
  \'for'    : 'requirements'
\}                                             " Add support for Python requirements files

" This is at the bottom to ensure it loads after any other plugins that may
" use it
Plug 'ryanoasis/vim-devicons'                  " Icons for various filetypes

call plug#end()
