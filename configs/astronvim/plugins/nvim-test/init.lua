return {
  cmd = {
    "TestSuite",
    "TestFile",
    "TestNearest",
    "TestLast",
    "TestVisit",
    "TestEdit",
  },
  config = function()
    require("user.plugins.nvim-test.config")
  end,
}
