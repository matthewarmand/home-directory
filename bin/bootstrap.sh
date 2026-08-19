#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
  echo "Don't run this script as root! Exiting"
  exit 1
fi

sudo pacman -S --needed -q \
  base \
  base-devel \
  git

if [ ! -d ~/.git/ ]; then
  git clone git@github.com:matthewarmand/home-directory.git ~
fi

if [ "$(git --git-dir ~/.git/ config --local --get oh-my-zsh.hide-info)" -ne 1 ]; then
  git --git-dir ~/.git/ config --local oh-my-zsh.hide-info 1
fi
git config --global advice.detachedHead false
git config --global core.editor vim
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global push.autoSetupRemote true

rbw config set pinentry pinentry-gnome3
rbw config set lock_timeout 300

if [ ! -d ~/.oh-my-zsh/ ]; then
  mkdir -p ~/.oh-my-zsh/
  git clone git@github.com:ohmyzsh/ohmyzsh.git ~/.oh-my-zsh/
fi

if ! command -v paru >/dev/null; then
  mkdir -p ~/.cache/paru/clone/paru/
  git clone https://aur.archlinux.org/paru.git ~/.cache/paru/clone/paru/
  (
    cd ~/.cache/paru/clone/paru/ || exit 1
    makepkg -sric
  )
fi

base_system=(
  'arch-audit'
  'archlinux-contrib'
  'base'
  'base-devel'
  'docker'
  'docker-compose'
  'fwupd'
  'fzf'
  'git'
  'networkmanager'
  'pacman-contrib'
  'pipewire'
  'python-black'
  'rbw'
  'ruff'
  'shellcheck'
  'shfmt'
  'vim'
  'vim-ale'
  'vim-fugitive-git'
  'vim-gitgutter-git'
  'yamllint'
  'zsh'
)
gui_environment=(
  'dunst'
  'firefox-developer-edition'
  'gcr'
  'grim'
  'i3status-rust'
  'jellyfin-tui'
  'otf-font-awesome'
  'pavucontrol'
  'playerctl'
  'rofi-rbw'
  'slurp'
  'swappy'
  'sway'
  'swaybg'
  'swayidle'
  'swaylock'
  'terminator'
  'tidal-hifi-bin'
  'wofi'
  'wtype'
  'xdg-desktop-portal-wlr'
)
laptop=(
  'brightnessctl'
)
work=(
  'slack-desktop-wayland'
)

machine_name="$(uname -n)"
case "$machine_name" in
  kvasir)
    packages+=(
      "${base_system[@]}"
      "${gui_environment[@]}"
    )
    ;;
  marmand-metametrics)
    packages+=(
      "${base_system[@]}"
      "${gui_environment[@]}"
      "${laptop[@]}"
      "${work[@]}"
    )
    ;;
  *)
    echo "Don't recognize machine $machine_name, can't determine package list."
    exit 1
    ;;
esac

# shellcheck disable=SC2048,SC2086 # need to pass packages as unquoted
paru -S --needed ${packages[*]}
