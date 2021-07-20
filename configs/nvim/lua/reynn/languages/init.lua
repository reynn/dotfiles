return {
  setup = function(opts)
    require('reynn.languages.rust').setup(opts.rust or {})
  end
}
