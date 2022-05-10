return {
	["C-d"] = {
		n = { "<c-r>=strftime('%Y-%m-%d')<cr>", "Y-m-d" },
		x = { "<c-r>=strftime('%m/%d/%y')<cr>", "m/d/y" },
		f = { "<c-r>=strftime('%B %d, %Y')<cr>", "B d, Y" },
		X = { "<c-r>=strftime('%H:%M')<cr>", "H:M" },
		F = { "<c-r>=strftime('%H:%M:%S')<cr>", "H:M:S" },
		d = { "<c-r>=strftime('%Y/%m/%d %H:%M:%S -')<cr>", "Y/m/d H:M:S -" },
	},
}
