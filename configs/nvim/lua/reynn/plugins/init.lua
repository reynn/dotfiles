return {
  setup = function(cfg)
    require("reynn.plugins.buffers").setup(cfg.buffers or {})
    require("reynn.plugins.colors").setup(cfg.colors or {})
    require("reynn.plugins.completion").setup(cfg.completion or {})
    require("reynn.plugins.finder").setup(cfg.finder or {})
    require("reynn.plugins.git").setup(cfg.git or {})
    require("reynn.plugins.lsp").setup(cfg.lsp or {})
    require("reynn.plugins.start_screen").setup(cfg.start_screen or {})
    require("reynn.plugins.statusline").setup(cfg.statusline or {})
    require("reynn.plugins.syntax").setup(cfg.syntax or {})
    require("reynn.plugins.tabline").setup(cfg.tabline or {})
    require("reynn.plugins.term").setup(cfg.term or {})
    require("reynn.plugins.textalign").setup(cfg.textalign or {})
  end
}
