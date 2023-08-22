#!/bin/sh
# required-arch-package :: bitwarden-cli
# required-arch-package :: jq
# required-arch-package :: wl-clipboard
# required-arch-package :: wofi
# required-arch-package :: yad

session=$BW_SESSION

status=$(bw status --session="$session" | jq -r '.status')
if [ "$status" = 'unauthenticated' ]; then
  pieces=$(yad --form --field=Email --field=Password:H --field=MFA)
  email=$(echo "pieces" | awk -F'|' '{print $1}')
  password=$(echo "$pieces" | awk -F'|' '{print $2}')
  mfa=$(echo "$pieces" | awk -F'|' '{print $3}')
  session=$(bw login --raw "$email" --method 0 --password "$password" --code "$mfa")
elif [ "$status" = 'locked' ]; then
  pieces=$(yad --form --field=Password:H)
  password=$(echo "$pieces" | awk -F'|' '{print $1}')
  session=$(bw unlock --raw "$password")
fi

selection=$(bw list items --session="$session" | jq -r '.[] .name' | wofi -idG)
if [ -n "$selection" ]; then
  bw get password --session="$session" "$selection" | wl-copy
fi
