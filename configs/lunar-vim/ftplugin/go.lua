local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup({{ exe = "gofmt", filetypes = {"go"} }})

local dap_install = require("dap-install")
dap_install.config("go_delve", {})
