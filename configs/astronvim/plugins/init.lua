return {
  -- Disable AstroNvim default plugins
  ["max397574/better-escape.nvim"] = { disable = true },
  ["Darazaki/indent-o-matic"] = { disable = true },
  ["numToStr/Comment.nvim"] = { disable = true },
  ["lukas-reineke/indent-blankline.nvim"] = { disable = true },
  ["rafamadriz/friendly-snippets"] = { event = { nil } },
  ["williamboman/nvim-lsp-installer"] = {
    opt = true,
    setup = function()
      -- reload the current file so lsp actually starts for it
      vim.defer_fn(function()
        vim.cmd('if &ft == "packer" | echo "" | else | silent! e %')
      end, 0)
    end,
    config = function()
      require("configs.nvim-lsp-installer").config()
      require("configs.lsp")
    end,
  },
  -- Color Schemes
  {
    "rebelot/kanagawa.nvim",
    -- after = "lualine",
    config = function()
      if require('user').colorscheme == "kanagawa" then
        print('Configuring Kanagawa theme')
        require("kanagawa").setup({
          dimInactive = true,
          globalStatus = true,
        })
      end
    end,
  },
  {
    "luisiacc/gruvbox-baby",
    config = function()
      if require('user').colorscheme == "gruvbox-baby" then
        print('Configuring GruvboxBaby theme')
        vim.g.gruvbox_baby_telescope_theme = 1
        vim.g.gruvbox_baby_background_color = "medium"

        vim.g.gruvbox_baby_comment_style = "italic"
        vim.g.gruvbox_baby_function_style = "bold,italic"
        vim.g.gruvbox_baby_keyword_style = "bold"
        vim.g.gruvbox_baby_variable_style = "standout"
      end
    end,
  },
  {
    "tiagovla/tokyodark.nvim",
    config = function()
      if require('user').colorscheme == "tokyodark" then
        print('Configuring TokyoDark theme')
        vim.g.tokyodark_enable_italic_comment = true
        vim.g.tokyodark_enable_italic = true
      end
    end,
  },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      if require('user').colorscheme == "catppuccin" then
        print("Setting up Catppuccin theme")
        require("catppuccin").setup({
          term_colors = true,
          integrations = {
            indent_blankline = {
              enabled = false,
            },
            lsp_trouble = false,
            neotree = {
              enabled = true,
            },
            nvimtree = {
              enabled = false,
            },
            telescope = true,
            ts_rainbow = true,
            which_key = true,
          },
        })
      end
    end,
  },
  {
    "projekt0n/circles.nvim",
    requires = {
      {"kyazdani42/nvim-web-devicons"},
      {"kyazdani42/nvim-tree.lua", opt = true},
    },
    config = function()
      require("circles").setup()
    end
  },
  -- general vim improvements
  { "folke/trouble.nvim", cmd = "TroubleToggle" },
  {
    "echasnovski/mini.nvim",
    after = "nvim-treesitter",
    config = require("user.plugins.mini"),
  },
  { "junegunn/vim-easy-align" },
  { "tpope/vim-repeat" },
  { "gpanders/editorconfig.nvim" },
  {
    "dhruvasagar/vim-table-mode",
    cmd = "TableModeToggle",
    setup = require("user.plugins.vim-table"),
  },
  {
    "nvim-telescope/telescope-project.nvim",
    after = "telescope.nvim",
    config = function()
      require("telescope").load_extension("project")
    end,
  },
  {
    "nvim-telescope/telescope-dap.nvim",
    after = "telescope.nvim",
    config = function()
      require("telescope").load_extension("dap")
    end,
  },
  {
    "nvim-telescope/telescope-packer.nvim",
    after = "telescope.nvim",
    config = function()
      require("telescope").load_extension("packer")
    end,
  },
  {
    "cljoly/telescope-repo.nvim",
    after = "telescope.nvim",
    config = function()
      require("telescope").load_extension("repo")
    end,
  },
  {
    "klen/nvim-test",
    cmd = {
      "TestSuite",
      "TestFile",
      "TestNearest",
      "TestLast",
      "TestVisit",
      "TestEdit",
    },
    config = require('user.plugins.nvim_test'),
  },
  {
    "folke/zen-mode.nvim",
    config = require('user.plugins.zen_mode'),
  },
  -- Text objects/Motions and TreeSitter enhancements
  { "bkad/CamelCaseMotion" },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  },
  {
    "ziontee113/syntax-tree-surfer",
    module = "syntax-tree-surfer",
  },
  -- LSP additions
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function()
      require("lsp_signature").on_attach()
    end,
  },
  {
    "m-demare/hlargs.nvim",
    after = "nvim-treesitter",
    config = function()
      require("hlargs").setup({})
    end,
  },
  { "onsails/lspkind.nvim" },
  -- {
  --   "tzachar/cmp-tabnine",
  --   after = "nvim-cmp",
  --   run = "./install.sh",
  --   requires = "hrsh7th/nvim-cmp",
  --   event = "InsertEnter",
  --   config = require('user.plugins.tabnine'),
  -- },
  -- DAP:
  {
    "mfussenegger/nvim-dap",
    config = require("user.plugins.dap-config"),
  },
  {
    "rcarriga/nvim-dap-ui",
    after = { "nvim-dap", "rust-tools.nvim" },
    config = require("user.plugins.dap_ui"),
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    after = "nvim-dap",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
  -- Language specific additions
  {
    "lukas-reineke/headlines.nvim",
    ft = { "markdown", "rmd" },
    config = require("user.plugins.markdown"),
  },
  {
    "ellisonleao/glow.nvim",
    ft = { "markdown", "rmd" },
    config = require("user.plugins.glow"),
  },
  {
    "simrat39/rust-tools.nvim",
    ft = { "rust", "rs" },
    config = require("user.plugins.rust_tools"),
  },
  {
    "Saecki/crates.nvim",
    after = "nvim-cmp",
    config = require("user.plugins.crates-nvim"),
    ft = { "toml" },
  },
  {
    'crispgm/nvim-go',
    config = require('user.plugins.golang'),
    ft = { "golang", "go" },
  },
}
