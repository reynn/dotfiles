# Alacritty Configuration

Alacritty is setup to call [tmux](/configs/tmux/readme.md) automatically on
open, tries to attach an existing session first then falls back to creating a new session

## Key Bindings

| Key                      | Action                        |
| ------------------------ | ----------------------------- |
| cmd+t                    | Tmux: New window              |
| cmd+{h,j,k,l}            | Tmux: Navigate between panes  |
| cmd+{up,down,left,right} | Tmux: Resize current pane     |
| cmd+[0-9]                | Tmux: Jump to numbered window |
| cmd+x                    | Tmux: Close current pane      |
| cmd+w                    | Tmux: List windows            |
| cmd+s                    | Tmux: Split horizontal        |
| cmd+shift+s              | Tmux: Split vertical          |
| cmd+z                    | Job: send fg<cr>              |
