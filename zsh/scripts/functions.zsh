#!/bin/zsh

function __close_all_apps() {
  apps=$(osascript -e 'tell application "System Events" to get name of (processes where background only is false)' | awk -F ', ' '{for(i=1;i<=NF;i++) printf "%s;", $i}')
  while [ "$apps" ] ;do
    app=${apps%%;*}
    if [[ $app != 'alacritty' && $app != 'alacritty-popup' ]]
    then
      pkill -x echo $app
    fi

    [ "$apps" = "$app" ] && \
        apps='' || \
        apps="${apps#*;}"
  done
}

function reboot() {
  __close_all_apps

  sudo reboot
}

function shutdown() {
  __close_all_apps

  sudo shutdown -h now
}

function gretting_message() {
  e_bold "Host name: $(hostname), User: $(whoami)"
  e_success "On $(sw_vers -productName)$(sw_vers -productVersion), build version: $(sw_vers -buildVersion)"
  e_success "Shell: $(zsh --version)"
  e_success "Terminal color: $TERM"
  e_success "Uptime: $(uptime | sed 's/.*up \([^,]*\), .*/\1/')"

  echo "Hello Huy Duong.\n\nHave a good day!" | cowsay | lolcat
}

