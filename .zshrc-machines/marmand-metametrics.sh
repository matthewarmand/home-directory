#!/usr/bin/sh -e

# Do something like this for mysql dumps etc
# docker run -it -v $(pwd):/code/`basename $PWD` -w /code/`basename $PWD` mysql:5.6 bash

# https://stackoverflow.com/questions/46704572/git-error-encountered-7-files-that-should-have-been-pointers-but-werent
alias fix-lfs='git lfs uninstall && git reset --hard && git lfs install && git pull'

unused_text_keys() {
  grep -E '\"[a-zA-Z0-9\.]*\":' src/i18n/en-us.json | awk '{print $1}' | sed 's/[":]//g' | while IFS="$(printf '\n')" read -r k; do grep -rq "$k" --include="*.js" src || echo "$k"; done
}

open_jira_tabs() {
  if [ ! -f "$1" ]; then
    echo "Unable to find list of tickets in file ($1). Please specify."
  else
    while read -r l; do
      if [ "$(printf '%s' "$l" | cut -c 1)" != "#" ]; then
        firefox-developer-edition -new-tab "https://metametrics.atlassian.net/browse/$l"
      fi
    done <"$1"
  fi
}

mm_git_config() {
  [ -d "$1" ] && base_dir="$1" || base_dir="/home/matt/development/mm"
  echo "Using $base_dir as base directory"

  find "$base_dir" -type d -name ".git" -not -path "*/venv/*" | while IFS="$(printf '\n')" read -r d; do
    git_config=$(GIT_DIR="$d" git config -l)
    if echo "$git_config" | grep -q "metametrics" && ! echo "$git_config" | grep -q "@lexile.com"; then
      GIT_DIR="$d" git config --local --replace user.name "Matthew Armand"
      GIT_DIR="$d" git config --local --replace user.email marmand@lexile.com
      echo "Updated config for $(dirname "$d")"
    fi
  done
}
