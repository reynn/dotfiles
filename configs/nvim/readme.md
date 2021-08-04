# NeoVim Configuration

| Requirement | Minimum Version | Main Site                     |
| ----------- | --------------- | ----------------------------- |
| Neovim      | 0.5.x+          | [neovim.io][main-site-neovim] |
|             |                 |                               |

## Keymappings

| Modifier | Key    |
| -------- | ------ |
| <leader> | `\`    |
| <C>      | `Ctrl` |

| Mode  |   Key Combo   | Plugin                               | Action                                        |
| :---: | :-----------: | ------------------------------------ | --------------------------------------------- |
|  `*`  |    `<C-\>`    | [ToggleTerm][nvim-plugin-toggleterm] | Toggle a floating terminal window             |
|  `n`  | `<leader>ff`  | [Telescope][nvim-plugin-telescope]   | Fuzzy finder for files                        |
|  `n`  | `<leader>fg`  | [Telescope][nvim-plugin-telescope]   | Live grep for file contents                   |
|  `n`  | `<leader>fb`  | [Telescope][nvim-plugin-telescope]   | Fuzzy finder for open nvim buffers            |
|  `n`  | `<leader>fh`  | [Telescope][nvim-plugin-telescope]   | Fuzzy finder for nvim help topics             |
|  `i`  |     `ta`      | [Easy-Align][nvim-plugin-easy-align] | Start easy align with a text motion (vipta*-) |
|  `x`  | `<leader>tal` | [Easy-Align][nvim-plugin-easy-align] | Start interactive EasyAlign in live mode      |
|  `x`  | `<leader>ta=` | [Easy-Align][nvim-plugin-easy-align] | Align to a `=` character                      |
|  `x`  | `<leader>ta-` | [Easy-Align][nvim-plugin-easy-align] | Align to a `-` character                      |
|  `x`  | `<leader>ta ` | [Easy-Align][nvim-plugin-easy-align] | Align to a ` ` character                      |
|       |               |                                      |                                               |
|       |               |                                      |                                               |

<!-- LINKS -->

[main-site-neovim]: https://neovim.io/
[nvim-plugin-toggleterm]: https://github.com/
[nvim-plugin-telescope]: https://github.com/
[nvim-plugin-easy-align]:
