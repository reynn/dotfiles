" Plugin Config: neoclide/coc.nvim

" Functions: CoC
" =========================================================

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:status_diagnostics() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction

function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

" Basic configuration
" =========================================================

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold   :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{s:status_diagnostics()}

" Using CocList

nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr> " show all diagnostics
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>  " Manage extensions
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>    " Show commands
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>     " Find symbol of current document
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>  " Search workspace symbols
nnoremap <silent> <space>j  :<C-u>CocNext<cr>             " Do default action for next item.
nnoremap <silent> <space>k  :<C-u>CocPrev<cr>             " Do default action for previous item.
nnoremap <silent> <space>p  :<C-u>CocListResume<cr>       " Resume latest coc list

" Extension management
let g:coc_global_extensions = [
  \ 'coc-actions',
  \ 'coc-git',
  \ 'coc-highlight',
  \ 'coc-json',
  \ 'coc-lists',
  \ 'coc-markdownlint',
  \ 'coc-python',
  \ 'coc-rls',
  \ 'coc-snippets',
  \ 'coc-spell-checker',
  \ 'coc-tabnine',
  \ 'coc-yaml',
  \ 'coc-yank',
\ ]

nmap <leader>rn <Plug>(coc-rename)
" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Extension Configuration

" =============================================================================
" CoC.Extension Setup: https://github.com/iamcco/coc-actions
" =============================================================================

" Remap for do codeAction of selected region
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" =============================================================================
" CoC.Extension Setup: https://github.com/weirongxu/coc-calc
" =============================================================================

" append result on current expression
nmap <leader>ca <Plug>(coc-calc-result-append)
" replace result on current expression
nmap <leader>cr <Plug>(coc-calc-result-replace)

" =============================================================================
" CoC.Extension Setup: https://github.com/iamcco/coc-spell-checker
" =============================================================================

" =============================================================================
" CoC.Extension Setup: https://github.com/neoclide/coc-json
" =============================================================================

" =============================================================================
" CoC.Extension Setup: https://github.com/neoclide/coc-rls
" =============================================================================

" =============================================================================
" CoC.Extension Setup: https://github.com/neoclide/coc-yaml
" =============================================================================

" =============================================================================
" CoC.Extension Setup: https://github.com/neoclide/coc-python
" =============================================================================

" =============================================================================
" CoC.Extension Setup: https://github.com/neoclide/coc-highlight
" =============================================================================

autocmd CursorHold * silent call CocActionAsync('highlight')

" =============================================================================
" CoC.Extension Setup: https://github.com/fannheyward/coc-markdownlint
" =============================================================================

" =============================================================================
" CoC.Extension Setup: https://github.com/neoclide/coc-tabnine
" =============================================================================

" =============================================================================
" CoC.Extension Setup: https://github.com/neoclide/coc-yank
" =============================================================================

nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>

" =============================================================================
" CoC.Extension Setup: https://github.com/neoclide/coc-git
" =============================================================================

" =============================================================================
" CoC.Extension Setup: https://github.com/neoclide/coc-lists
" =============================================================================

" =============================================================================
" CoC.Extension Setup: https://github.com/neoclide/coc-snippets
" =============================================================================

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space()    ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
