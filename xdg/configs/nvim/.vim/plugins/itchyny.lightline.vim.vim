" Plugin Config: itchyny/lightline.vim

let g:lightline = {
  \ 'colorscheme': 'jellybeans',
  \ 'component_function': {
  \   'filename': 'LightlineFilename',
  \   'gitbranch': 'FugitiveHead',
  \   'cocstatus': 'coc#status'
  \ },
  \ 'active': {
  \   'left': [
  \     ['mode'],
  \     ['filename', 'modified', 'cocstatus']
  \   ],
  \   'right': [
  \     ['lineinfo'],
  \     ['gitbranch', 'fileencoding', 'filetype']
  \   ]
  \ }
\ }

let g:lightline.subseparator = {
  \ 'left': '', 'right': ''
\ }

let g:lightline.separator = {
  \ 'left': '', 'right': ''
\ }
