return {
  config = function()
    require("kanagawa").setup({
      dimInactive = true,
      globalStatus = true,
    })
  end
}
