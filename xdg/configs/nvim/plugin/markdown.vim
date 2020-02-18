au FileType markdown nmap <leader>tt :call ToggleTodo()<cr>
au FileType markdown nmap <leader>tn :call NewTodo()<cr>
au FileType markdown nmap <leader>ta :call ArchiveDone()<cr>

function! ToggleTodo()
  normal! mz^
  if getline(".")[col(".")-1] != '-'
    execute 'normal I - [x]  '
  endif
  normal! 0f[l

  if getline(".")[col(".")-1] == ' '
    normal! rx
  else
    execute 'normal r '
  endif
  normal! `z
endfunction

function! NewTodo()
  execute 'normal o- [ ]  '
  normal! i
endfunction

function! ArchiveDone()
  let @x = ''
  normal! mZ^
  execute '%g/- \[x\]/d X'
  execute 'e ./todo_archive.md'
  normal! G"xp
  normal! `Z
endfunction
