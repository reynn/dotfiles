" FROM https://github.com/saaguero/vim-textobj-pastedtext

function! SelectPasted()
  return ['v', getpos("'["), getpos("']")]
endfunction

if exists('g:loaded_textobj_pastedtext')
  finish
endif

if !exists("g:pastedtext_select_key")
  let g:pastedtext_select_key = 'gb'
endif

call textobj#user#plugin('pastedtext', {
\   'text': {
\     'select-function': 'SelectPasted',
\     'select': g:pastedtext_select_key,
\   },
\ })

let g:loaded_textobj_pastedtext = 1
