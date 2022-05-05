-- Defines the profiles you want to use
return "astronvim", {
	astronvim = {
		"https://github.com/AstroNvim/AstroNvim.git",
		{
			url = "https://github.com/AstroNvim/AstroNvim.git",
			plugins = "packer",
			preconfigure = "packer",
			config = "PackerSync",
		},
	},
	doomnvim = {
		"https://github.com/NTBBloodbath/doom-nvim.git",
		{
			url = "https://github.com/NTBBloodbath/doom-nvim.git",
			plugins = "packer",
			preconfigure = "doom-nvim",
		},
	},
	lunarvim = {
		"https://github.com/LunarVim/LunarVim.git",
		{
			url = "https://github.com/LunarVim/LunarVim.git",
			plugins = "packer",
			preconfigure = "packer",
			config = "PackerSync",
		},
	},
}
