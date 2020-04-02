" Plugin Config: andymass/vim-matchup

let g:matchup_enabled = 1

augroup matchup_matchparen_highlight
  autocmd!
  autocmd ColorScheme * hi MatchParen guifg=red
augroup END

hi MatchWord cterm=underline gui=underline,bold
