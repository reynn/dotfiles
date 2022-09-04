-- Defines the profiles you want to use
return "astronvim",
	{
		astronvim = {
			"https://github.com/AstroNvim/AstroNvim.git",
			{
				url = true,
				preconfigure = "packer",
				config = "PackerSync",
			},
		},
		doomnvim = {
			"https://github.com/NTBBloodbath/doom-nvim.git",
			{
				url = true,
				config = "PackerSync",
				preconfigure = "doom-nvim",
			},
		},
	}
