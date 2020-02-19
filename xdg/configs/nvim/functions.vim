" =============================================================================
" # Custom Functions
" =============================================================================

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! LightlineMode()
  return expand('%:t') =~# '^__Tagbar__' ? 'Tagbar'       :
       \ expand('%:t') ==# 'ControlP'    ? 'CtrlP'        :
       \ &filetype ==# 'unite'           ? 'Unite'        :
       \ &filetype ==# 'vimfiler'        ? 'VimFiler'     :
       \ &filetype ==# 'coc-explorer'    ? 'CoC Explorer' :
       \ &filetype ==# 'nerdtree'        ? 'NERDTree'     :
       \ &filetype ==# 'vimshell'        ? 'VimShell'     :
       \ lightline#mode()
endfunction

function! s:list_cmd()
  let base = fnamemodify(expand('%'), ':h:.:S')
  return base == '.' ? 'fd --type file --follow' : printf('fd --type file --follow | proximity-sort %s', shellescape(expand('%')))
endfunction
