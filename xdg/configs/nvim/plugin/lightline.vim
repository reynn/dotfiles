" Plugin Config: itchyny/lightline.vim

let g:lightline = {
  \ 'colorscheme': 'jellybeans',
  \ 'component_function': {
  \   'filename': 'LightlineMode',
  \   'gitbranch': 'FugitiveHead',
  \   'cocstatus': 'coc#status'
  \ },
  \ 'active': {
  \   'left': [
  \     ['mode'],
  \     ['filename', 'modified', 'cocstatus']
  \   ],
  \   'right': [
  \     ['cocstatus','lineinfo'],
  \     ['gitbranch', 'fileencoding', 'filetype']
  \   ]
  \ }
\ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

let g:lightline.subseparator = {
  \ 'left': '', 'right': ''
\ }

let g:lightline.separator = {
  \ 'left': '', 'right': ''
\ }
