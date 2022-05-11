return {
  ["J"] = {
    function()
      require("syntax-tree-surfer").surf("next", "visual")
    end,
    "Navigate to next TS node",
  },
  ["K"] = {
    function()
      require("syntax-tree-surfer").surf("prev", "visual")
    end,
    "Navigate to previous TS node",
  },
  ["H"] = {
    function()
      require("syntax-tree-surfer").surf("parent", "visual")
    end,
    "Navigate to parent TS node",
  },
  ["L"] = {
    function()
      require("syntax-tree-surfer").surf("child", "visual")
    end,
    "Navigate to child TS node",
  },
}
