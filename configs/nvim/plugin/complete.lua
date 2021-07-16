local utils = require('reynn.utils')
local map = utils.map
local opt = utils.opt

opt('completeopt', 'menuone,noselect')

local opts = { noremap = true, silent = true, expr = true }

map({'i'}, '<C-Space>', "compe#complete()", opts)
map({'i'},   '<CR>',    "compe#confirm(luaeval(\"require 'nvim-autopairs'.autopairs_cr()\"))", opts)
map({'i'},   '<C-e>',   "compe#close('<C-e>')", opts)
map({'i'},   '<C-f>',   "compe#scroll({ 'delta': +4 })", opts)
map({'i'},   '<C-d>',   "compe#scroll({ 'delta': -4 })", opts)

vim.api.nvim_command('highlight link CompeDocumentation NormalFloat')

require('compe').setup({
  enabled          = true;
  autocomplete     = true;
  debug            = false;
  min_length       = 2;
  preselect        = 'enable';
  throttle_time    = 80;
  source_timeout   = 200;
  incomplete_delay = 400;
  max_abbr_width   = 40;
  max_kind_width   = 10;
  max_menu_width   = 10;
  documentation    = true;
  source = {
    path = { menu = "率" };
    buffer = { menu = "﬘" };
    calc = { menu = "" };
    vsnip = { menu = "" };
    nvim_lsp = { menu = "" };
    nvim_lua = true;
    tabnine = {
      max_line        = 100;
      max_num_results = 10;
      priority        = 20;
      menu            = "";
    };
    spell         = { menu = "暈" };
    tags          = { menu = "" };
    snippets_nvim = false;
    treesitter    = { menu = "" };
  }
})
