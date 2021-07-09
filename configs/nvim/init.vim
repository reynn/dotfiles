call plug#begin('~/.vim/plugged')

" Plug 'https://github.com/towolf/vim-helm' " Add Helm integration
" Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin' " Add git integration to Nerdtree
Plug 'https://github.com/bkad/CamelCaseMotion' " using w, b to traverse words considers camel case separate words
Plug 'https://github.com/junegunn/vim-easy-align'
Plug 'https://github.com/kana/vim-textobj-user'
Plug 'https://github.com/mhinz/vim-crates'
Plug 'https://github.com/michaeljsmith/vim-indent-object'
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/nvim-lua/plenary.nvim'
Plug 'https://github.com/nvim-lua/popup.nvim'
Plug 'https://github.com/nvim-telescope/telescope.nvim'
Plug 'https://github.com/pedrohdz/vim-yaml-folds'
Plug 'https://github.com/tpope/vim-repeat' " Improve the builtin `.` repeat
Plug 'https://github.com/tpope/vim-surround' " text motions to surround object with a character `ys$'` will surround from cursor to end of line with single quote
Plug 'https://github.com/vim-scripts/argtextobj.vim'
Plug 'https://github.com/nvim-lua/lsp_extensions.nvim' " Extensions to built-in LSP, for example, providing type inlay hints
Plug 'https://github.com/nvim-lua/completion-nvim' " Autocompletion framework for built-in LSP
Plug 'https://github.com/eddyekofo94/gruvbox-flat.nvim'
Plug 'https://github.com/simrat39/rust-tools.nvim'
Plug 'https://github.com/Xuyuanp/nerdtree-git-plugin'             " Add git information to NerdTree
Plug 'https://github.com/airblade/vim-gitgutter'                  " Show git changes in margin of file buffer
Plug 'https://github.com/andymass/vim-matchup'                    " Highlight, navigate and operate on sets of matching text
Plug 'https://github.com/frazrepo/vim-rainbow'                    " Colorize tabs, parens to make them easier to see
Plug 'https://github.com/itchyny/lightline.vim'                   " Adds a powerline like status bar at the bottom
Plug 'https://github.com/machakann/vim-highlightedyank'           " Highlights line after y is pressed
Plug 'https://github.com/noscripter/tabman.vim'                   " Simple management of tabs in Vim
" This is at the bottom to ensure it loads after any other plugins that may
" use it
Plug 'https://github.com/ryanoasis/vim-devicons'                  " Icons for various filetypes

call plug#end()
