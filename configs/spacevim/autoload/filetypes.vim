augroup filetypedetect

  au BufNewFile,BufRead *.dockerfile set filetype=Dockerfile
  au BufNewFile,BufRead *.md         set filetype=markdown
  au BufNewFile,BufRead *.coffee     set filetype=coffee
  au BufNewFile,BufRead *.sjs        set filetype=javascript
  au BufNewFile,BufRead *.es6        set filetype=javascript
  au BufNewFile,BufRead *.jsx        set filetype=javascript
  au BufNewFile,BufRead *.ftl        set filetype=ftl
  au BufNewFile,BufRead *.jade       set filetype=jade
  au BufNewFile,BufRead *.styl       set filetype=stylus
  au BufNewFile,BufRead *.less       set filetype=less

augroup END
