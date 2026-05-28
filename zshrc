# Enable Powerlevel10k instant prompt. Must stay at top.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export DOT_DIR="$HOME/dotfiles"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  docker
  python
  gh
  uv
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
  fzf-tab
  you-should-use
)

source $ZSH/oh-my-zsh.sh
source ~/aliases.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide (smarter cd)
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"

# uv
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"

# p10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
