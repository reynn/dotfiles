" plugin config: itchyny/lightline.vim

let g:lightline = {
  \ 'colorscheme': 'PaperColor',
  \ 'active': {
  \   'left': [
  \     ['mode', 'paste'],
  \     ['fugitive', 'filename']
  \   ],
  \   'right': [
  \     ['column', 'cocstatus'],
  \     ['filetype']
  \   ]
  \ },
  \ 'inactive': {
  \   'left': [
  \     ['filename']
  \   ],
  \   'right': [
  \     ['lineinfo'],
  \     ['percent']
  \   ]
  \ },
  \ 'component': {
  \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
  \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
  \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}',
  \   'lineinfo': '%3l:%-2c',
  \   'column': '%2c ',
  \ },
  \ 'component_function': {
  \   'cocstatus': 'coc#status'
  \ },
  \ 'component_visible_condition': {
  \   'readonly': '(&filetype!="help"&& &readonly)',
  \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
  \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
  \ },
  \ 'separator': { 'left': " ", 'right': " " },
  \ 'subseparator': { 'left': " ", 'right': " " }
  \ }

autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

let g:lightline.subseparator = {
  \ 'left': '', 'right': ''
\ }

let g:lightline.separator = {
  \ 'left': '', 'right': ''
\ }
