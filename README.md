# dotfiles

Personal shell configuration for macOS and Linux servers.

## Install

```bash
git clone https://github.com/bcevoli/dotfiles ~/dotfiles
cd ~/dotfiles
bash install.sh
```

Re-running `install.sh` is safe — it skips anything already installed.

## Contents

| File | Description |
|------|-------------|
| `zshrc` | Zsh config — Oh My Zsh, Powerlevel10k, all plugins |
| `aliases.sh` | All aliases and shell functions |
| `p10k.zsh` | Powerlevel10k prompt config |
| `tmux.conf` | Mouse, vim keys, Catppuccin status bar, `Ctrl+A` prefix |
| `gitconfig` | Git user config |
| `inputrc` | Aggressive tab completion, no "display all X?" prompts |
| `ssh_config_template` | SSH template with port forwards for Jupyter/MLflow/TensorBoard |
| `install.sh` | Installs everything and symlinks configs |

## What gets installed

**Shell:**
- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)
- [fzf-tab](https://github.com/Aloxaf/fzf-tab) — fuzzy tab completion for everything
- [you-should-use](https://github.com/MichaelAquilina/zsh-you-should-use)
- [fzf](https://github.com/junegunn/fzf) — fuzzy Ctrl+R history, Ctrl+T file search
- [zoxide](https://github.com/ajeetdsouza/zoxide) — smarter `cd`

**CLI tools** (install separately via brew / apt):
- [`bat`](https://github.com/sharkdp/bat) — better `cat` with syntax highlighting
- [`eza`](https://github.com/eza-community/eza) — better `ls` with colors and git status
- [`ripgrep`](https://github.com/BurntSushi/ripgrep) — faster `grep`
- [`mosh`](https://mosh.org/) — persistent SSH that survives network changes

## Server setup

1. Copy `ssh_config_template` to `~/.ssh/config` and fill in your server details
2. Connect with `mosh <user>@<server>` instead of `ssh` for persistent sessions
3. Port forwards for TensorBoard (6006), MLflow (5000), Jupyter (8888) are pre-configured
