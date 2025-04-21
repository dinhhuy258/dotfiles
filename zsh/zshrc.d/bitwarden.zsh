#!/bin/zsh

function _bw_unlocked() {
  if [[ -z "${BW_SESSION}" || "$(bw status | jq -r '.status')" != "unlocked" ]]; then
    echo "Bitwarden is locked. Unlocking..."
    export BW_SESSION="$(bw unlock --raw)"

    # Check if unlock was successful
    if [[ $? -ne 0 || -z "${BW_SESSION}" ]]; then
      echo "Failed to unlock Bitwarden. Aborting."
      return 1
    fi
    echo "Bitwarden unlocked successfully."
  fi
  return 0
}

function bw_load_ssh_keys() {
  _bw_unlocked || return 1

  echo "Fetching SSH keys from Bitwarden..."
  bw list items | jq -r '.[] | select(.sshKey != null) | "\(.name)\t\(.id)"' | \
    fzf --delimiter='\t' --with-nth=1 | \
    cut -f2 | \
    xargs -I{} sh -c 'bw get item {} | jq -r ".sshKey.privateKey" | ssh-add -'
}

function bw_get_password() {
  _bw_unlocked || return 1

  echo "Fetching logins from Bitwarden..."
  local selected_item
  selected_item=$(bw list items | jq -r '.[] | select(.login != null) | "\(.name)\t\(.login.username // "")\t\(.id)"' | \
    fzf --delimiter='\t' --with-nth=1,2 --header="Name"$'\t'"Username" | \
    cut -f3)

  if [[ -n "$selected_item" ]]; then
    bw get item "$selected_item" | jq -r '.login.password' | pbcopy
    echo "Password copied to clipboard!"
  else
    echo "No item selected."
  fi
}

function bw_get_totp() {
  _bw_unlocked || return 1

  echo "Fetching items with TOTP from Bitwarden..."
  local selected_item
  selected_item=$(bw list items | jq -r '.[] | select(.login != null and .login.totp != null) | "\(.name)\t\(.login.username // "")\t\(.id)"' | \
    fzf --delimiter='\t' --with-nth=1,2 --header="Name"$'\t'"Username" | \
    cut -f3)

  if [[ -n "$selected_item" ]]; then
    bw get totp "$selected_item" | pbcopy
    echo "TOTP code copied to clipboard!"
  else
    echo "No item selected."
  fi
}
