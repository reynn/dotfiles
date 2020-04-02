" ================ script ===============================================
" interactive 'J', 'gJ' replacement with optional 'vim-repeat' support
" The last used separator is automatically reused as:
" a. default choice
" b. when repeating (=> non-interactive repeats: same range, same separator)
let g:last_join_separator = " "
function! s:interactiveJoin(use_last_sep,...) range
    if (a:use_last_sep == 0) "interactive, ask for separator to use
        call inputsave()
        echohl Question
        let l:sep = input("Separator:", g:last_join_separator)
        echohl None
        call inputrestore()
        redraw!
        let g:last_join_separator = l:sep "update last separator value
    else "non-interactive (when repeating with '.')
        let l:sep = g:last_join_separator
    endif
    if (a:0 == 0) "with no argument, remove indentation *and trailing spaces*
        let l:subst = 's/\s*\n\+\s*/\=' . "'" . l:sep . "'/"
    else " don't remove indentation or trailing spaces (act like 'gJ')
        let l:subst = 's/\n\+/\=' . "'" . l:sep . "'/"
    endif
    if a:firstline < a:lastline "join given range
        execute a:firstline . ',' . (a:lastline - 1) . l:subst
        let l:count = a:lastline - a:firstline + 1 "default count for repeat
    else "or join only with next line
        execute l:subst
        let l:count = 1 "default count for repeat
    endif
    "make command repeatable
    "(with the tpope/vim-repeat plugin: optional, recommended)
    if (a:0 == 0)
        silent! call repeat#set("\<Plug>(repeatJoin)", l:count)
    else
        silent! call repeat#set("\<Plug>(repeatGJoin)", l:count)
    endif
endfunction

noremap <silent> <Plug>(interactiveJoin)  :call <SID>interactiveJoin(0)<CR>
noremap <silent> <Plug>(interactiveGJoin) :call <SID>interactiveJoin(0,'g')<CR>
noremap <silent> <Plug>(repeatJoin)       :call <SID>interactiveJoin(1)<CR>
noremap <silent> <Plug>(repeatGJoin)      :call <SID>interactiveJoin(1,'g')<CR>

nmap J <Plug>(interactiveJoin)
xmap J <Plug>(interactiveJoin)
nmap gJ <Plug>(interactiveGJoin)
xmap gJ <Plug>(interactiveGJoin)
