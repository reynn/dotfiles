augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile /tmp/mutt*              setfiletype mail
  autocmd Filetype mail                              setlocal spell
  autocmd Filetype mail                              setlocal fo+=w
  " Git commit message
  autocmd Filetype gitcommit                         setlocal spell
  " nftables
  autocmd BufRead,BufNewFile *.nft setfiletype nftables
  autocmd BufRead zsh.snippets setfiletype snippets
  " Go shortcuts
  au FileType go nmap <leader>t <Plug>(go-test)
  au FileType go nmap <leader>r <Plug>(go-rename)
  au FileType go nmap <leader>c <Plug>(go-coverage)
  au FileType go nmap <leader>f <Plug>(go-fmt)
  " Rust language server
  "au FileType rust :LanguageClientStart
  " Shorter columns in text
  autocmd Filetype tex setlocal spell
  autocmd Filetype text setlocal spell
  autocmd Filetype markdown setlocal spell
augroup END

au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.sh set filetype=zsh
au BufNewFile,BufRead *.bash set filetype=zsh
au BufNewFile,BufRead *.json set filetype=json
au BufNewFile,BufRead *.coffee set filetype=coffee
au BufNewFile,BufRead *.sjs set filetype=javascript
au BufNewFile,BufRead *.es6 set filetype=javascript
au BufNewFile,BufRead *.jsx set filetype=javascript
au BufNewFile,BufRead *.ftl set filetype=ftl
au BufNewFile,BufRead *.jade set filetype=jade
au BufNewFile,BufRead *.styl set filetype=stylus
au BufNewFile,BufRead *.less set filetype=less
