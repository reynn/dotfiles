" Plugin Config: xolox/vim-session

set sessionoptions-=tabpages " If you only want to save the current tab page
set sessionoptions-=options  " Don't persist options and mappings because it can corrupt sessions
set sessionoptions-=help     " If you don't want help windows to be restored
set sessionoptions-=buffers  " Don't save hidden and unloaded buffers in sessions


let g:session_autosave_periodic=5 " Autosave the session every 5 minutes
let g:session_autosave_silent=1   " Dont show notifications when the autosave session occurs
