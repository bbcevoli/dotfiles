#!/bin/bash
# Dotfiles installer — symlinks configs and installs plugins.
# Safe to re-run: skips anything already done.
# This branch (offline) uses vendor/ instead of cloning from GitHub.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENDOR="$DOTFILES/vendor"
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

if command -v zsh &>/dev/null; then

# ── Oh My Zsh ─────────────────────────────────────────────────────────────────

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    info "Installing Oh My Zsh"
    cp -r "$VENDOR/oh-my-zsh" "$HOME/.oh-my-zsh"
    success "Oh My Zsh installed"
else
    skip "Oh My Zsh already installed"
fi

# ── Powerlevel10k ─────────────────────────────────────────────────────────────

if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    info "Installing Powerlevel10k"
    mkdir -p "$ZSH_CUSTOM/themes"
    cp -r "$VENDOR/themes/powerlevel10k" "$ZSH_CUSTOM/themes/powerlevel10k"
    success "Powerlevel10k installed"
else
    skip "Powerlevel10k already installed"
fi

# ── Zsh plugins ───────────────────────────────────────────────────────────────

install_plugin() {
    local name="$1"
    local dir="$ZSH_CUSTOM/plugins/$name"
    if [ ! -d "$dir" ]; then
        info "Installing $name"
        mkdir -p "$ZSH_CUSTOM/plugins"
        cp -r "$VENDOR/plugins/$name" "$dir"
        success "$name installed"
    else
        skip "$name already installed"
    fi
}

install_plugin zsh-autosuggestions
install_plugin zsh-syntax-highlighting
install_plugin zsh-history-substring-search
install_plugin you-should-use
install_plugin fzf-tab

# ── fzf ───────────────────────────────────────────────────────────────────────

if [ ! -d "$HOME/.fzf" ]; then
    info "Installing fzf"
    cp -r "$VENDOR/fzf" "$HOME/.fzf"
    chmod +x "$HOME/.fzf/bin/fzf"
    # Write shell integration files directly — avoids fzf's install script
    # which tries to run the binary to verify it (fails cross-platform).
    cat > "$HOME/.fzf.zsh" << 'EOF'
# fzf
[[ ":$PATH:" != *":$HOME/.fzf/bin:"* ]] && PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
source <(fzf --zsh)
EOF
    cat > "$HOME/.fzf.bash" << 'EOF'
# fzf
[[ ":$PATH:" != *":$HOME/.fzf/bin:"* ]] && PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
eval "$(fzf --bash)"
EOF
    success "fzf installed"
else
    skip "fzf already installed"
fi

else
    skip "zsh not found — skipping zsh plugins, fzf"

# ── Bash fallback ─────────────────────────────────────────────────────────────

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
echo "Note: zoxide was not installed. Add it via your package manager if needed (apt/brew/etc)."
