local packer = nil

-- Automatically run :PackerCompile whenever plugins.lua is updated with an autocommand:
vim.cmd [[ autocmd BufWritePost plugins.lua PackerCompile ]]

local function init()
  if packer == nil then
    packer = require('packer')
    packer.init { disable_commands = true }
  end

  local use = packer.use
  packer.reset()

  -- Packer
  use { '~/git/github.com/wbthomason/packer.nvim' }

  -- Custom plugins
  use { '~/git/github.com/reynn/crates-rs.lua' }

  -- NVIM 0.5.0 Specific
  use { 'https://github.com/akinsho/nvim-toggleterm.lua' } -- persist and toggle multiple terminals
  use { 'https://github.com/neovim/nvim-lspconfig' } -- collection of common configs for the built-in LSP
  use { 'https://github.com/nvim-lua/lsp_extensions.nvim' } -- Extensions to built-in LSP, for example, providing type inlay hints
  use { 'https://github.com/nvim-lua/lsp-status.nvim' } -- generate statusline components from the built-in LSP
  use { 'https://github.com/kabouzeid/nvim-lspinstall' } -- Install language servers automatically
  use { 'https://github.com/nvim-lua/popup.nvim' } -- An implementation of the Popup API from vim in Neovim
  use { 'https://github.com/nvim-telescope/telescope.nvim' } -- highly extendable fuzzy finder over lists
  use { 'https://github.com/simrat39/rust-tools.nvim' } -- Initialize the builtin LSP with sane Rust defaults
  use { "https://github.com/ray-x/lsp_signature.nvim" } -- Adds method/function signatures while typing
  use {
    'https://github.com/nvim-treesitter/nvim-treesitter', -- Syntax highlighting... to the max
    -- config = "require('treesitter')",
    run = ':TSUpdate'
  }
  use {
    'https://github.com/tzachar/compe-tabnine',
    run = './install.sh',
    requires = {'https://github.com/hrsh7th/nvim-compe'}
  }
  use {
    'https://github.com/lewis6991/gitsigns.nvim',
    requires = {'https://github.com/nvim-lua/plenary.nvim'}
  }
  use {
    'https://github.com/glepnir/galaxyline.nvim',
      branch = 'main',
      requires = {'kyazdani42/nvim-web-devicons'}
  }
  use {
    'seblj/nvim-tabline',
    requires = {'kyazdani42/nvim-web-devicons'}
  }

  -- Color Schemes
  use { 'https://github.com/eddyekofo94/gruvbox-flat.nvim' }

  use { 'https://github.com/andymass/vim-matchup' }           -- Highlight, navigate and operate on sets of matching text
  use { 'https://github.com/bkad/CamelCaseMotion' }           -- using w, b to traverse words considers camel case separate words
  use { 'https://github.com/frazrepo/vim-rainbow' }           -- Colorize tabs, parens to make them easier to see
  use { 'https://github.com/junegunn/vim-easy-align' }        -- Text alignment
  use { 'https://github.com/kana/vim-textobj-user' }
  -- use { 'https://git.peppe.rs/vim/better-text-objs' }
  use { 'https://github.com/machakann/vim-highlightedyank' }  -- Highlights line after y is pressed
  use { 'https://github.com/michaeljsmith/vim-indent-object' }
  use { 'https://github.com/puremourning/vimspector' }
  use { 'https://github.com/hrsh7th/vim-vsnip' }
  use { 'https://github.com/hrsh7th/vim-vsnip-integ' }
  use { 'https://github.com/tpope/vim-commentary' }
  use { 'https://github.com/tpope/vim-repeat' }               -- Improve the builtin `.` repeat
  use { 'https://github.com/tpope/vim-surround' }             -- text motions to surround object with a character `ys$'` will surround from cursor to end of line with single quote
  use { 'https://github.com/vim-scripts/argtextobj.vim' }
  use {
    'https://github.com/windwp/nvim-autopairs',
    config = "require('nvim-autopairs').setup()"
  }

  --
  -- Language options
  --
  -- use {
  --   'https://github.com/fatih/vim-go',
  --   ft = 'go',
  --   event = 'InsertEnter',
  --   cmd = {'GoImport', 'GoImports', 'GoTest', 'GoBuild'},
  --   run = ':GoInstallBinaries'
  -- }
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})

return plugins
