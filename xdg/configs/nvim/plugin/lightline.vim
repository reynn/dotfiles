" plugin config: itchyny/lightline.vim

let g:lightline = {
  \ 'colorscheme': 'PaperColor',
  \ 'component_function': {
  \   'filename': 'LightlineMode',
  \   'gitbranch': 'FugitiveHead',
  \   'cocstatus': 'coc#status',
  \   'blame': 'LightlineGitBlame',
  \ },
  \ 'active': {
  \   'left': [
  \     ['mode', 'blame'],
  \     ['filename', 'modified']
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
