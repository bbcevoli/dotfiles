#!/bin/bash
# Dotfiles installer — symlinks configs and installs plugins.
# Safe to re-run: skips anything already done.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

info()    { echo "  [·] $*"; }
success() { echo "  [✓] $*"; }
skip()    { echo "  [–] $*"; }

# ── Symlinks ──────────────────────────────────────────────────────────────────

symlink() {
    local src="$DOTFILES/$1" dst="$HOME/$2"
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        skip "$2 already linked"
    else
        [ -f "$dst" ] && mv "$dst" "$dst.bak" && info "backed up existing $2 → $2.bak"
        ln -sf "$src" "$dst"
        success "linked $2"
    fi
}

symlink zshrc        .zshrc
symlink aliases.sh   aliases.sh
symlink p10k.zsh     .p10k.zsh
symlink gitconfig    .gitconfig
symlink tmux.conf    .tmux.conf
symlink inputrc      .inputrc

# ── Oh My Zsh ─────────────────────────────────────────────────────────────────

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    success "Oh My Zsh installed"
else
    skip "Oh My Zsh already installed"
fi

# ── Powerlevel10k ─────────────────────────────────────────────────────────────

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    info "Installing Powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k "$ZSH_CUSTOM/themes/powerlevel10k"
    success "Powerlevel10k installed"
else
    skip "Powerlevel10k already installed"
fi

# ── Zsh plugins ───────────────────────────────────────────────────────────────

install_plugin() {
    local name="$1" repo="$2"
    local dir="$ZSH_CUSTOM/plugins/$name"
    if [ ! -d "$dir" ]; then
        info "Installing $name"
        git clone --depth=1 "$repo" "$dir"
        success "$name installed"
    else
        skip "$name already installed"
    fi
}

install_plugin zsh-autosuggestions      https://github.com/zsh-users/zsh-autosuggestions
install_plugin zsh-syntax-highlighting  https://github.com/zsh-users/zsh-syntax-highlighting
install_plugin zsh-history-substring-search https://github.com/zsh-users/zsh-history-substring-search
install_plugin you-should-use           https://github.com/MichaelAquilina/zsh-you-should-use
install_plugin fzf-tab                  https://github.com/Aloxaf/fzf-tab

# ── fzf ───────────────────────────────────────────────────────────────────────

if [ ! -d "$HOME/.fzf" ]; then
    info "Installing fzf"
    git clone --depth=1 https://github.com/junegunn/fzf "$HOME/.fzf"
    "$HOME/.fzf/install" --all --no-update-rc
    success "fzf installed"
else
    skip "fzf already installed"
fi

# ── zoxide ────────────────────────────────────────────────────────────────────

if ! command -v zoxide &>/dev/null; then
    info "Installing zoxide"
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    success "zoxide installed"
else
    skip "zoxide already installed"
fi

# ── Bash fallback (when zsh is not available) ─────────────────────────────────

if ! command -v zsh &>/dev/null; then
    BASHRC="$HOME/.bashrc"
    MARKER="# dotfiles"
    if ! grep -q "$MARKER" "$BASHRC" 2>/dev/null; then
        printf '\n%s\n[ -f ~/aliases.sh ] && source ~/aliases.sh\n' "$MARKER" >> "$BASHRC"
        success "added aliases to .bashrc"
    else
        skip "aliases already in .bashrc"
    fi
fi

echo ""
echo "Done. Restart your shell or run: source ~/.zshrc (zsh) / source ~/.bashrc (bash)"
