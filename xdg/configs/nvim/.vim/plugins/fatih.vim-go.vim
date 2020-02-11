" Plugin Config: fatih/vim-go

let g:go_addtags_transform = 'snakecase'
let g:go_auto_sameids = 1     " highlight the variable throughout code
let g:go_auto_type_info = 1
let g:go_bin_path = expand("~/go/bin")
let g:go_def_mode='gopls'
let g:go_doc_max_height = 40
let g:go_fmt_command = "goimports"
let g:go_fmt_fail_silently = 1
let g:go_info_mode='gopls'
let g:go_mod_fmt_autosave = 1
let g:go_play_open_browser = 0
let g:go_snippet_engine = "ultisnips"
let g:go_template_file = expand("$XDG_CONFIG_HOME/nvim/_go.go")
let g:go_template_test_file = expand("$XDG_CONFIG_HOME/nvim/_go_test.go")
let g:go_updatetime = 500

let g:go_fmt_options = {
  \ 'gofmt': '-s',
  \ 'goimports': '-local github.concur.com',
  \ }
