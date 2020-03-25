#!/usr/bin/bash -e

alias tizonia='source /home/matt/development/personal/docker-tizonia/docker-tizonia'

open-jira-tabs() {
  if [[ ! -f "$1" ]]; then
    echo "Unable to find list of tickets in file ($1). Please specify."
  else
    while read -r l; do
      if [[ ${l:0:1} != "#" ]]; then
        firefox-developer-edition -new-tab "https://metametrics.atlassian.net/browse/$l"
      fi
    done <"$1"
  fi
}

mm-git-config() {
  orig_dir=$(pwd)
  [[ -d "$1" ]] && base_dir="$1" || base_dir="/home/matt/development/mm"
  echo "Using $base_dir as base directory"

  find "$base_dir" -type d -name ".git" | while IFS=$'\n' read -r d; do
    cd "$(dirname "$d")"
    git_config=$(git config -l)
    if echo "$git_config" | grep -q "metametrics" ; then
      if ! echo "$git_config" | grep -q "@lexile.com" ; then
        git config --local --replace user.name "Matthew Armand"
        git config --local --replace user.email marmand@lexile.com
        echo "Updated config for $(pwd)"
      fi
    fi
    cd "$base_dir"
  done
  cd "$orig_dir"
}
