return {
	"bkad/CamelCaseMotion",
	event = "BufEnter",
	config = function()
		return {
			mappings = {
				n = {
					["w"] = { "<Plug>CamelCaseMotion_w", silent = true },
					["b"] = { "<Plug>CamelCaseMotion_b", silent = true },
					["e"] = { "<Plug>CamelCaseMotion_e", silent = true },
					["ge"] = { "<Plug>CamelCaseMotion_ge", silent = true },
				},
				o = {
					["iw"] = { "<Plug>CamelCaseMotion_iw", silent = true },
					["ib"] = { "<Plug>CamelCaseMotion_ib", silent = true },
					["ie"] = { "<Plug>CamelCaseMotion_ie", silent = true },
				},
				x = {
					["iw"] = { "<Plug>CamelCaseMotion_iw", silent = true },
					["ib"] = { "<Plug>CamelCaseMotion_ib", silent = true },
					["ie"] = { "<Plug>CamelCaseMotion_ie", silent = true },
				},
				i = {
					["<S-Left>"] = { "<C-o><Plug>CamelCaseMotion_w", silent = true },
					["<S-Right>"] = { "<C-o><Plug>CamelCaseMotion_b", silent = true },
				},
			},
		}
	end,
}
