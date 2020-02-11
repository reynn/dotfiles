augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile /tmp/mutt*              setfiletype mail
  autocmd Filetype mail                              setlocal spell
  autocmd Filetype mail                              setlocal fo+=w
  " Git commit message
  autocmd Filetype gitcommit                         setlocal spell
  " nftables
  autocmd BufRead,BufNewFile *.nft setfiletype nftables
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
