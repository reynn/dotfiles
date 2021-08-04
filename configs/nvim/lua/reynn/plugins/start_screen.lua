local start_screen = {}

function start_screen.setup(opts)
  -- local opt = require('reynn.utils').opt
  -- opt('startify_lists', {})

  vim.g.startify_change_to_vcs_root = true
  vim.g.startify_files_number = 6
  vim.g.startify_commands = {
    {u = {"Packer Update", ":PackerUpdate"}},
    {c = {"Packer Clean", ":PackerClean"}}
  }
  vim.g.startify_lists = {
    {type = "commands", header = {"  Commands"}},
    {type = "dir", header = {"  MRU " .. vim.fn.getcwd()}},
    {type = "files", header = {"  MRU"}}
  }
end

return start_screen
