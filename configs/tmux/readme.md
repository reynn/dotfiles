# TMUX Configuration

Plugins managed with [TPM][tmux-plugin-manager]

## Plugins

| Name                                     | Description                            |
| ---                                      | ---                                    |
| [TPM][tmux-plugin-manager]               | Manages installation of other plugins. |
| [Sensible][tmux-plugin-sensible]         |                                        |
| [Pain Control][tmux-plugin-pain-control] |                                        |
| [Battery][tmux-plugin-battery]           |                                        |
| [Gruvbox][tmux-plugin-gruvbox]           |                                        |


## Glossary

1. [Windows][tmux-windows-and-panes]: Similar to a tab, within a session, can contain any number of panes.
1. [Session][tmux-clients-and-sessions]: Haven't made heavy use of this yet, can be used to switch contexts,
for instance between work/personal, or between rust,golang,fish projects etc., or
just different projects that require multiple windows.
1. [Pane][tmux-windows-and-panes]: Split of a window, can be resized and split quickly with hot keys.
Useful for opening extra terminals. Can be synchronized so typing goes to any number of panes.
1. [Status Line][tmux-status-line]: The bar that shows windows, date/time and tons of other information
extremely customizable.
1. [Buffers][tmux-buffers]: Paste buffers, can be set with copy mode.
1. [TPM][tmux-plugin-manager]: Install plugins with `[prefix]-I`.

## Key Bindings

| Key           | Action                                      |
| ------------- | ------------------------------------------- |
| `ctrl+a`      | Tmux prefix                                 |
| `[prefix]+[`  | Enter copy mode                             |
| `{CM}[space]` | Copy Mode: Start selection                  |
| `{CM}[enter]` | Copy Mode: Copy selection                   |
| `{CM}[esc]`   | Copy Mode: Clear selection                  |
| `[prefix]+b`  | List buffers                                |
| `[prefix]+P`  | Paste from buffer                           |
| `[prefix]+p`  | Select buffer                               |
| `[prefix]+,`  | Rename window                               |
| `[prefix]+&`  | Rename session                              |
| `[prefix]+>`  | Swap pane with the next one                 |
| `[prefix]+<`  | Swap pane with the previous one             |
| `[prefix]+\`  | Pane: Split vertical full                   |
| `[prefix]+-`  | Pane: Split horizontal                      |
| `[prefix]+_`  | Pane: Split horizontal full                 |
| `[prefix]+r`  | Reload tmux config                          |
| `[prefix]+z`  | Zoom current pane                           |
| `[prefix]+I`  | [TPM][tmux-plugin-manager]: Install plugins |

## Useful links

- [Tmux Cheatsheet][tmux-cheatsheet]: Quick reference for tmux, includes bindings and command equivalents.

[tmux-plugin-manager]: https://github.com/tmux-plugins/tpm
[tmux-plugin-sensible]: https://github.com/tmux-plugins/tmux-sensible
[tmux-plugin-pain-control]: https://github.com/tmux-plugins/tmux-pain-control
[tmux-plugin-gruvbox]: https://github.com/egel/tmux-gruvbox
[tmux-battery]: https://github.com/tmux-plugins/tmux-battery
[tmux-windows-and-panes]: https://manpages.ubuntu.com/manpages/xenial/man1/tmux.1.html#windows%20and%20panes
[tmux-clients-and-sessions]: https://manpages.ubuntu.com/manpages/xenial/man1/tmux.1.html#clients%20and%20sessions
[tmux-buffers]: https://manpages.ubuntu.com/manpages/xenial/man1/tmux.1.html#buffers
