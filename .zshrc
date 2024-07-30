# required-arch-package :: arch-audit
# required-arch-package :: fzf
# required-arch-package :: pacman-contrib
# required-arch-package :: zsh
# If you come from bash you might have to change your $PATH.
# export PATH=/home/matt/bin:/usr/local/bin:$PATH

# Add to Path local bin directory (user scripts)
export PATH=$PATH:/home/matt/bin

# for cli-visualizer
export TERM=rxvt-256color

# ssh
export SSH_KEY_PATH="/home/matt/.ssh/rsa_id"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Python
export PYTHONDONTWRITEBYTECODE=1

# Docker
export DOCKER_BUILDKIT=1 # Use buildkit by default for docker, docker compose

# Fuzzy Find
export FZF_BASE=/usr/share/fzf

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias adios='sudo shutdown -h +0'
alias cal='cal -m'
alias code-workspace='nohup terminator -l codeworkspace &>/dev/null & sleep 2; exit'
alias count-vulns="arch-audit -f %c | sed 's/, /\n/g' | sort -u | wc -l"
alias docker-here='docker run --rm -it -v $(pwd):/code/`basename $PWD` -w /code/`basename $PWD`'
alias git-root='cd $(git rev-parse --show-toplevel)'
alias journal-today='mkdir -p /home/matt/journal/$(date +%Y/%m/) && vim /home/matt/journal/$(date +%Y/%m/%d).md'
alias latest-tag='git fetch -q && git describe --tags $(git rev-list --tags --max-count=1)'
alias vi=vim

all-installed() {
  paru -Qe | awk '{print $1}' | while IFS=$'\n' read -r p; do
    paru -Qi "$p" | grep -Eq "Required By\s+:\sNone" && echo "$p"
  done
}

depends-on() {
  if [ -n "$1" ] && installed_packages=$(paru -Q | grep "$1") && [ -n "$installed_packages" ]; then
    echo "$installed_packages" | awk '{print $1}' | xargs paru -Qi | grep "Required By" | sed 's/Required By\s\+:\s//g' | sed 's/\b\s\+\b/\n/g' | grep -Ev "$1|None" | sort -u
  fi
}

purge-uninstalled-cache() {
  package_dirs="-c $(pacman-conf CacheDir)"
  for d in "${XDG_CACHE_HOME:-$HOME/.cache}"/paru/clone/*/; do
    package_dirs="$package_dirs -c $d"
  done
  eval "paccache -${1:-d} -k 0 -u $package_dirs"
}

git-fork() {
  origin_url=$(git remote show -n origin | grep 'Fetch URL' | sed 's/^.*Fetch URL:\s\+//')
  git remote add upstream "$origin_url"
  git remote add my "$(echo "$origin_url" | sed 's/:.*\//:matthewarmand\//')"
}

git-set-origin() {
  git remote set-url origin "$(git remote get-url "$1")"
}

# run machine-specific configuration if it exists
filename=/home/matt/.config/zshrc-machines/$(uname -n).sh
test -x "$filename" && source "$filename"
test -f /home/matt/.env && source /home/matt/.env

# oh-my-zsh Configuration

ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH="/home/matt/.oh-my-zsh"

ZSH_THEME="af-magic"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=7

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  fzf
  timer
)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir "$ZSH_CACHE_DIR"
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

init-sway() {
  if [ -f ~/exited-sway ]; then
    rm ~/exited-sway
  fi

  env XDG_CURRENT_DESKTOP=sway \
    QT_QPA_PLATFORM=wayland \
    QT_QPA_PLATFORMTHEME=qt6ct \
    /usr/bin/sway
}

if [ "$(tty)" = /dev/tty1 ] && [ ! -f ~/exited-sway ]; then
  init-sway
fi
