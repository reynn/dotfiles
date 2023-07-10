local hlargs = require('hlargs')

hlargs.setup({})

require('which-key').register({
  o = {
    name = "Options",
    h = {
      hlargs.toggle,
      "hlargs: Toggle"
    }
  }
}, {prefix = "<leader>"})
