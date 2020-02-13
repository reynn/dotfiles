" Plugin Config: neoclide/coc.nvim

map  <leader>f    :Prettier<CR>
nmap <silent> E   <Plug>(coc-diagnostic-prev)
nmap <silent> W   <Plug>(coc-diagnostic-next)
nmap <silent> gd  <Plug>(coc-definition)
nmap <silent> gy  <Plug>(coc-type-definition)
nmap <silent> gi  <Plug>(coc-implementation)
nmap <silent> gr  <Plug>(coc-references)

command! -nargs=0 Prettier :CocCommand prettier.formatFile

autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" CoC-Snippets

" Ctrl+l in insert mode to bring up snippets menu
imap <silent> <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<C-u>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<C-n>'

" Setup tab completion for snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
