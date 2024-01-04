#!/bin/zsh

bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)

green=$(tput setaf 76)
blue=$(tput setaf 38)
tan=$(tput setaf 3)
red=$(tput setaf 1)

function e_arrow() {
  printf "➜ $1\n"
}

function e_success() {
  printf "${green}✔ %s${reset}\n" "$@"
}

function e_warning() {
  printf "${tan}➜ %s${reset}\n" "$@"
}

function e_error() {
  printf "${red}✖ %s${reset}\n" "$@"
}

function e_bold() {
  printf "${bold}%s${reset}\n" "$@"
}

function e_note() {
  printf "${underline}${bold}${blue}Note:${reset}  ${blue}%s${reset}\n" "$@"
}
