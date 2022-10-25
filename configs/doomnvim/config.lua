-- doom_config - Doom Nvim user configurations file
--
-- This file contains the user-defined configurations for Doom nvim.
-- Just override stuff in the `doom` global table (it's injected into scope
-- automatically).

-- ADDING A PACKAGE
--
doom.use_package(
  {
    "ur4ltz/surround.nvim",
    config = function()
      require("surround").setup({ mappings_style = "sandwich" })
    end,
  },
  -- ## Colorschemes
  { "rebelot/kanagawa.nvim" },
  { "luisiacc/gruvbox-baby" },
  { "tiagovla/tokyodark.nvim" },
  { "catppuccin/nvim" },
  -- ## NeoVim UI/UX improvements
  {
    "projekt0n/circles.nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("circles").setup()
    end,
  },
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    module = "zen-mode",
  },
  { "echasnovski/mini.nvim" },
  { "tpope/vim-repeat" },
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
  },
  -- ## Telescope extensions
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
  -- ## Text Objects/Motions
  { "bkad/CamelCaseMotion" },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
  },
  {
    "ziontee113/syntax-tree-surfer",
    module = "syntax-tree-surfer",
  },
  -- ## LSP Additions
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
  },
  {
    "m-demare/hlargs.nvim",
    after = "nvim-treesitter",
  },
  { "onsails/lspkind.nvim" },
  -- ## Language Additions
  {
    "simrat39/rust-tools.nvim",
    after = { "nvim-lspconfig" },
  },
  {
    "Saecki/crates.nvim",
    after = "nvim-cmp",
    event = { "BufRead Cargo.toml" },
  },
  { "ray-x/go.nvim" }
)
-- doom.use_package()

-- ADDING A KEYBIND
--
-- doom.use_keybind({
--   -- The `name` field will add the keybind to whichkey
--   {"<leader>s", name = '+search', {
--     -- Bind to a vim command
--     {"g", "Telescope grep_string<CR>", name = "Grep project"},
--     -- Or to a lua function
--     {"p", function()
--       print("Not implemented yet")
--     end, name = ""}
--   }}
-- })

-- ADDING A COMMAND
--
-- doom.use_cmd({
--   {"CustomCommand1", function() print("Trigger my custom command 1") end},
--   {"CustomCommand2", function() print("Trigger my custom command 2") end}
-- })

-- ADDING AN AUTOCOMMAND
--
doom.use_autocmd({
  {
    "FileType",
    "javascript",
    function()
      print("This is a javascript file")
    end,
  },
}, {
  {
    "BufWritePre",
    "*",
    function()
      vim.lsp.buf.formatting_sync()
    end,
  },
})

doom.indent = 2

-- vim: sw=2 sts=2 ts=2 expandtab
