#!/usr/bin/zsh

alias hg-root='cd $(hg root)'

export FZF_BASE=/usr/share/fzf

# Specify plugins for zsh
plugins=(
  fzf
  git
  mercurial
  virtualenv
)
