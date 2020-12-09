# Fish Configuration

## Plugins

Plugins are managed by [Fisher][fish-plugin-fisher], run `fisher update` to install plugins.

| Plugin                           | Description                                     |
| ------                           | -----------                                     |
| [Z][fish-plugin-z]               | Jump around directories                         |
| [fzf.fish][fish-plugin-fzf.fish] | FZF key bindings, more convenient than official |
| [fish-nvm][fish-plugin-fish-nvm] | Use Node Version Manager in Fish                |
| [bass][fish-plugin-bass]         | Use bash utilities in Fish                      |
| [YSU][fish-plugin-ysu]           | Reminder of aliases                             |
| [getopts][fish-plugin-getopts]   | Fish version of GNU getopts for flag parsing    |
|                                  |                                                 |

## Keybindings

| Key        | Result                                             |
| ---        | ------                                             |
| CTRL+f     | (fzf.fish) List files tab to select multiple files |
| CTRL+ALT+s | (fzf.fish) Use git status to show modified files   |
| CTRL+ALT+l | (fzf.fish) Show git log and copy the selected hash |
| CTRL+r     | (fzf.fish) Reverse-i-Search, back search commands  |
| CTRL+v     | (fzf.fish) Shell variables                         |

[fish-plugin-fisher]: https://github.com/orgebucaran/fisher
[fish-plugin-z]: https://github.com/jethrokuan/z
[fish-plugin-fzf.fish]: https://github.com/PatrickF1/fzf.fish
[fish-plugin-fish-nvm]: https://github.com/FabioAntunes/fish-nvm
[fish-plugin-getopts]: https://github.com/jorgebucaran/getopts.fish
[fish-plugin-bass]: https://github.com/edc/bass
[fish-plugin-ysu]: https://github.com/paysonwallach/fish-you-should-use
