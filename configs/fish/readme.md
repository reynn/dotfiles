# Fish Configuration

## Function naming

Following a namespacing structure to organize functions based on tools, separated by a period `.`. lets look at some examples:

```plaintext
Format: <tool>.<optional_subject>.<action>*
# actions are typically one of [list, create, update, remove, connect, generate]. This should not limit naming though and others should be freely considered.
```

[dotfiles.ansible.update][./functions/dotfiles.ansible.update.fish]
[dotfiles.env.update][./functions/dotfiles.env.update.fish]
[dotfiles.system.update][./functions/dotfiles.system.update.fish]
[dotfile.update][./functions/dotfiles.update.fish]
[ansible.config.generate][./functions/ansible.config.generate.fish]

Helper functions are functions that dont execute any permanent action and should have no long term affect on the environment.
They typically are used to create complex JSON or YAML on the fly for things like the AWS CLI or the `jfrog` cli.
They should be named with `_ (underscores)` instead of `. (period)` and be prefixed by 2 or more `_ (underscores)` to differentiate from normal functions.

## Plugins

Plugins are managed by [Fisher][fish-plugin-fisher], run `fisher update` to install plugins.

| Plugin                                             | Description                                     |
| -------------------------------------------------- | ----------------------------------------------- |
| [Fisher][fish-plugin-fisher]                       | The Plugin Manager                              |
| [getopts][fish-plugin-getopts]                     | Fish version of GNU getopts for flag parsing    |
| [Z][fish-plugin-z]                                 | Jump around directories                         |
| [fzf.fish][fish-plugin-fzf.fish]                   | FZF key bindings, more convenient than official |
| [fish-nvm][fish-plugin-fish-nvm]                   | Use Node Version Manager in Fish                |
| [bass][fish-plugin-bass]                           | Use bash utilities in Fish                      |
| [YSU][fish-plugin-ysu]                             | Reminder of aliases                             |
| [colored_man_pages][fish-plugin-colored_man_pages] |                                                 |
| [fish-git-util][fish-plugin-git-util]              |                                                 |
| [xxh][fish-plugin-xxh]                             |                                                 |
| [gitignore][fish-plugin-gitignore]                 |                                                 |
| [puffer-fish][fish-plugin-puffer-fish]             |                                                 |

## Keybindings

| Key        | Result                                             |
| ---------- | -------------------------------------------------- |
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
[fish-plugin-colored_man_pages]: https://github.com/PatrickF1/colored_man_pages.fish
[fish-plugin-git-util]: https://github.com/fishpkg/fish-git-util
[fish-plugin-xxh]: https://github.com/xxh/xxh
[fish-plugin-gitignore]: https://github.com/sijad/gitignore
[fish-plugin-puffer-fish]: https://github.com/nickeb96/puffer-fish
