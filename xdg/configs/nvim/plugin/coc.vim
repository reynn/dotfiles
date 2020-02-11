" Plugin Config: neoclide/coc.nvim

map <leader>f :Prettier<CR>
nmap <silent> E <Plug>(coc-diagnostic-prev)
nmap <silent> W <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

command! -nargs=0 Prettier :CocCommand prettier.formatFile

autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" Extensions

let g:coc_global_extensions = 'coc-json coc-snippets coc-tabnine'
