#!/bin/sh

if [ "$(id -u)" -eq 0 ]; then
  echo "Don't run this script as root! Exiting"
  exit 1
fi

if ! command -v git >/dev/null; then
  sudo pacman -S git
fi

if [ ! -d ~/.oh-my-zsh/ ]; then
  mkdir -p ~/.oh-my-zsh/
  git clone git@github.com:ohmyzsh/ohmyzsh.git ~/.oh-my-zsh/
fi

if ! command -v paru >/dev/null; then
  mkdir -p ~/.cache/paru/clone/paru-bin/
  git clone https://aur.archlinux.org/paru-bin.git ~/.cache/paru/clone/paru-bin/
  (
    cd ~/.cache/paru/clone/paru-bin/ || exit 1
    makepkg -sric
    sudo pacman -U
  )
fi

# shellcheck disable=SC2046 # quotes break feeding this list of packages into paru
paru -S --needed -q $(git --git-dir ~/.git/ ls-files | grep -v '.bootstrap.sh\|.zshenv' | sed 's/^/\/home\/matt\//g' | xargs grep 'required-arch-packages ::' | awk -F'::' '{print $2}' | tr '\n' ' ')
