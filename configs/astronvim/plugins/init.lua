return {
	-- ## Change AstroNvim plugin defaults
	["famiu/bufdelete.nvim"] = { disable = true },
	["numToStr/Comment.nvim"] = { disable = true },
	["max397574/better-escape.nvim"] = { disable = true },
	["lukas-reineke/indent-blankline.nvim"] = { disable = true },
	["Darazaki/indent-o-matic"] = { disable = true },

	-- ## Colorschemes
	["rebelot/kanagawa.nvim"] = require("user.plugins.colorschemes.kanagawa"),
	-- ["luisiacc/gruvbox-baby"] = require("user.plugins.colorschemes.gruvbox-baby"),
	-- ["tiagovla/tokyodark.nvim"] = require("user.plugins.colorschemes.tokyodark"),
	-- ["catppuccin/nvim"] = require("user.plugins.colorschemes.catppuccin"),

	-- -- ## NeoVim UI/UX improvements
	["projekt0n/circles.nvim"] = require("user.plugins.circles-nvim"),
	["folke/trouble.nvim"] = require("user.plugins.trouble"),
	["folke/zen-mode.nvim"] = require("user.plugins.zen-mode"),
	["echasnovski/mini.nvim"] = require("user.plugins.mini"),
	["klen/nvim-test"] = require("user.plugins.nvim-test"),
	["lukas-reineke/headlines.nvim"] = require("user.plugins.headlines"),
	{ "tpope/vim-repeat" },
	{ "junegunn/vim-easy-align" },

	-- -- ## Telescope extensions
	["nvim-telescope/telescope-project.nvim"] = require("user.plugins.telescope.project"),
	["nvim-telescope/telescope-packer.nvim"] = require("user.plugins.telescope.packer"),
	["nvim-telescope/telescope-dap.nvim"] = require("user.plugins.telescope.dap"),
	["cljoly/telescope-repo.nvim"] = require("user.plugins.telescope.repo"),

	-- -- ## Text Objects/Motions
	{ "bkad/CamelCaseMotion" },
	["nvim-treesitter/nvim-treesitter-textobjects"] = require("user.plugins.treesitter.textobjects"),
	["phaazon/hop.nvim"] = require("user.plugins.hop"),

	-- -- ## Treesitter additions
	["ziontee113/syntax-tree-surfer"] = require("user.plugins.syntax-tree-surfer"),

	-- -- ## LSP Additions
	["ray-x/lsp_signature.nvim"] = require("user.plugins.lsp-signature"),
	["m-demare/hlargs.nvim"] = require("user.plugins.hlargs"),

	-- -- ## DAP
	["mfussenegger/nvim-dap"] = require("user.plugins.dap"),
	["leoluz/nvim-dap-go"] = require("user.plugins.golang.dap"),
	["rcarriga/nvim-dap-ui"] = require("user.plugins.dap.ui"),
	["theHamsta/nvim-dap-virtual-text"] = require("user.plugins.dap.virtual-text"),

	-- -- ## Language Additions
	["simrat39/rust-tools.nvim"] = require("user.plugins.rust"),
	["Saecki/crates.nvim"] = require("user.plugins.rust.crates"),
	["ray-x/go.nvim"] = require("user.plugins.golang"),
	{ "hashivim/vim-terraform" },
}
