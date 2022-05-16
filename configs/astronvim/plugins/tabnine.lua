return function()
  astronvim.add_cmp_source({
    name = "cmp_tabnine",
    priority = 1500,
    keyword_length = 3,
  })
  local tabnine = require("cmp_tabnine.config")
  tabnine:setup({
    max_lines = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
    snippet_placeholder = "..",
    show_prediction_strength = true,
  })
end
