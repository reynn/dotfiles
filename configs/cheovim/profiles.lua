-- Defines the profiles you want to use
local profiles = {
	astronvim = {
		"https://github.com/AstroNvim/AstroNvim.git",
		{
			url = "https://github.com/AstroNvim/AstroNvim.git",
			plugins = "packer",
			preconfigure = "packer",
			config = "PackerSync",
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

return "astronvim", profiles
