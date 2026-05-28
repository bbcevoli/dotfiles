# -------------------------------------------------------------------
# personal
# -------------------------------------------------------------------

# path
alias path='echo $PATH | tr ":" "\n"'

alias cdg="cd ~/git"
alias dot="cd ~/dotfiles"
alias zrce='$EDITOR ~/dotfiles/zshrc'
alias ale='$EDITOR ~/dotfiles/aliases.sh'
alias dotup='cd ~/dotfiles && git pull && bash install.sh && source ~/.zshrc'
alias jp="jupyter lab"
alias hn="hostname"
alias mosh='mosh --predict=adaptive'    # smoother typing on laggy connections

# -------------------------------------------------------------------
# general
# -------------------------------------------------------------------

alias cl="clear"
alias reload='source ~/.zshrc'
alias serve='python3 -m http.server'
alias myip='curl -s ifconfig.me'
alias localip='ipconfig getifaddr en0 2>/dev/null || hostname -I | awk "{print \$1}"'
alias watch='watch -n1'
alias json='python3 -m json.tool'
alias largest='find . -type f -printf "%s %p\n" | sort -rn | head -20'

# file and directories
alias rm='rm -i'
alias rmd='rm -rf'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'

# find/read files
alias h='head'
alias t='tail'
alias tf='tail -f'
# alias rl="readlink -f"
alias fdir='find . -type d -name'
alias ff='find . -type f -name'
alias which='type -a'
alias grep='grep --color=auto'
alias rg='rg --color=auto'
alias psg='ps aux | grep'
alias topcpu='ps aux --sort=-%cpu | head'
alias topmem='ps aux --sort=-%mem | head'

# modern replacements
command -v bat  &>/dev/null && alias cat='bat --paging=never'
command -v eza  &>/dev/null && alias ls='eza --group-directories-first' && alias ll='eza -l --group-directories-first' && alias la='eza -la' && alias lt='eza --tree'

# storage
alias du='du -kh'
alias df='df -kTh'
alias usage='du -sh * 2>/dev/null | sort -rh'
alias dus='du -sckx * | sort -nr'
alias sz='du -sh'
alias diskw='watch -n5 df -h'
alias ports='ss -tulnp'

# archives
alias untar='tar -xvf'
alias targz='tar -czf'
alias untargz='tar -xzf'

# add to path
function add_to_path() {
    p=$1
    if [[ "$PATH" != *"$p"* ]]; then
      export PATH="$p:$PATH"
    fi
}

#
#-------------------------------------------------------------
# cd
#-------------------------------------------------------------

alias c='z'
alias cd='z'
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias /='cd /'

alias d='dirs -v'
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'


#-------------------------------------------------------------
# git
#-------------------------------------------------------------

alias g="git"
alias gcl="git clone"
alias ga="git add"
alias gaa="git add ."
alias gau="git add -u"
alias gc="git commit -m"
alias gp="git push"
alias gpf="git push -f"
alias gpo='git push origin $(git_current_branch)'
alias gpp='git push --set-upstream origin $(git_current_branch)'

alias gg='git gui'
alias glog='git log --oneline --all --graph --decorate'

alias gf="git fetch"
alias gl="git pull"

alias grb="git rebase"
alias grbm="git rebase master"
alias grbmain="git rebase main"
alias grbc="git rebase --continue"
alias grbs="git rebase --skip"
alias grba="git rebase --abort"

alias gd="git diff"
alias gdt="git difftool"
alias gs="git status"

alias gco="git checkout"
alias gcb="git checkout -b"
alias gcm="git checkout master"
alias gcmain="git checkout main"

alias grhead="git reset HEAD^"
alias grhard="git fetch origin && git reset --hard origin/$(git_current_branch)"

alias gst="git stash"
alias gstp="git stash pop"
alias gsta="git stash apply"
alias gstd="git stash drop"
alias gstc="git stash clear"

alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gcam='git commit -am'
alias gcane='git commit --amend --no-edit'
alias gdw='git diff --word-diff'
alias gundo='git reset --soft HEAD~1'
alias gwip='git add -A && git commit -m "WIP"'
alias gunwip='git reset HEAD~1'
alias gclean='git clean -fd'
alias gcl='git clone --depth=1'

#-------------------------------------------------------------
# tmux
#-------------------------------------------------------------

alias tmux='tmux -u'
alias tks='tmux kill-server'
alias ta="tmux attach"
alias taa="tmux attach -t"
alias tad="tmux attach -d -t"
alias td="tmux detach"
alias ts="tmux new-session -s"
alias tl="tmux list-sessions"
alias tkill="tmux kill-server"
alias tdel="tmux kill-session -t"

#-------------------------------------------------------------
# ls
#-------------------------------------------------------------

alias l="ls -CF --color=auto"
alias ll="ls -l --group-directories-first"
alias la='ls -Al'         # show hidden files
alias lx='ls -lXB'        # sort by extension
alias lk='ls -lSr'        # sort by size, biggest last
alias lc='ls -ltcr'       # sort by and show change time, most recent last
alias lu='ls -ltur'       # sort by and show access time, most recent last
alias lt='ls -ltr'        # sort by date, most recent last
alias lm='ls -al |more'   # pipe through 'more'
alias lr='ls -lR'         # recursive ls
alias tree='tree -Csu'    # nice alternative to 'recursive ls'

#-------------------------------------------------------------
# chmod
#-------------------------------------------------------------

chw () {
  if [ "$#" -eq 1 ]; then
    chmod a+w $1
  else
    echo "Usage: chw <dir>" >&2
  fi
}
chx () {
  if [ "$#" -eq 1 ]; then
    chmod a+x $1
  else
    echo "Usage: chx <dir>" >&2
  fi
}

#-------------------------------------------------------------
# env
#-------------------------------------------------------------
alias sv="source .venv/bin/activate"
alias de="deactivate"
alias ma="micromamba activate"
alias md="micromamba deactivate"
alias py="python3"
alias tb='tensorboard --logdir'
alias nb='jupyter nbconvert --to script'

# uv
alias uvs="uv sync"
alias uvr="uv run"
alias uva="uv add"
alias uvad="uv add --dev"
alias uvrm="uv remove"

#-------------------------------------------------------------
# docker
#-------------------------------------------------------------
alias dk='docker'
alias dkps='docker ps'
alias dkpsa='docker ps -a'
alias dkrm='docker rm $(docker ps -aq)'
alias dkrmi='docker rmi $(docker images -q)'
alias dklog='docker logs -f'
alias dksh='docker exec -it'

#-------------------------------------------------------------
# GPU
#-------------------------------------------------------------
alias gpu="nvidia-smi"
alias gpuw="watch -n1 nvidia-smi"
alias gpumem="nvidia-smi --query-gpu=index,memory.used,memory.free --format=csv"

# -------------------------------------------------------------------
# Slurm
# -------------------------------------------------------------------
alias q='squeue -o "%.18i %.9P %.8j %.8u %.2t %.10M %.6D %N %.10b"'
alias qw='watch squeue -o "%.18i %.9P %.8j %.8u %.2t %.10M %.6D %N %.10b"'
alias qq='squeue -u $(whoami) -o "%.18i %.9P %.8j %.8u %.2t %.10M %.6D %N %.10b"'
alias qtop='scontrol top'
alias qdel='scancel'
alias qnode='sinfo -Ne --Format=NodeHost,CPUsState,Gres,GresUsed'
alias qinfo='sinfo'
alias qhost='scontrol show nodes'
# Submit a quick GPU test job
alias qtest='sbatch --gres=gpu:1 --wrap="hostname; nvidia-smi"'
alias qlogin='srun --gres=gpu:1 --pty $SHELL'
# Cancel all your queued jobs
alias qclear='scancel -u $(whoami)'
# Functions to submit quick jobs with varying GPUs
# Usage: qrun 4 script.sh → submits 'script.sh' with 4 GPUs
qrun() {
  sbatch --gres=gpu:"$1" "$2"
}
