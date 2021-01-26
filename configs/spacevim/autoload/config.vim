function! config#before() abort
    " let g:python3_host_prog = "~/.config/nvim/py3-env/bin/python"
    set t_Co=256
    set termguicolors
    if has('nvim')
      autocmd BufRead Cargo.toml call crates#toggle()
    endif
endfunction

function! config#after() abort
    set t_Co=256
    set termguicolors
endfunction
