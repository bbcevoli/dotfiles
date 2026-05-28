# dotfiles

Personal shell configuration for macOS and Linux servers.

## Contents

| File | Description |
|------|-------------|
| `zshrc` | Zsh config — Oh My Zsh, Powerlevel10k, all plugins |
| `aliases.sh` | All aliases and shell functions |
| `p10k.zsh` | Powerlevel10k prompt config |
| `tmux.conf` | Tmux config — mouse, vim keys, Catppuccin status bar |
| `gitconfig` | Git user config |
| `install.sh` | Installs everything and symlinks configs |

## Install

```bash
git clone https://github.com/bcevoli/dotfiles ~/dotfiles
cd ~/dotfiles
bash install.sh
```

Re-running `install.sh` is safe — it skips anything already installed.

## What gets installed

- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
- [you-should-use](https://github.com/MichaelAquilina/zsh-you-should-use)
- [fzf](https://github.com/junegunn/fzf)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
