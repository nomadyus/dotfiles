#!/bin/sh
## Dotfiles setup script
set -e

DIR=$(pwd)
HOME_DIR=~
BASH_DIR="${DIR}/bash"
ALIASES="aliases.sh"
ENVIRONMENT="env.sh"
BASH_PROFILE=".bash_profile"

printf "\nPreparing the bash environment using the dotfiles.\n"

if [ -f "${BASH_DIR}/${ALIASES}" ]; then
  printf "\nRunning the Aliases script (${BASH_DIR}/${ALIASES}).\n"
  ln -fs "${BASH_DIR}/${ALIASES}" "${HOME_DIR}/.${ALIASES}"
  source "${HOME_DIR}/.${ALIASES}"
  printf "Sourced aliases successfully.\n"
else 
  printf "The Aliases script (${BASH_DIR}/${ALIASES}) doesn't exist.\n"
fi

if [ -f "${BASH_DIR}/${ENVIRONMENT}" ]; then
  printf "\nRunning the Environment variable script (${BASH_DIR}/${ENVIRONMENT}).\n"
  ln -fs "${BASH_DIR}/${ENVIRONMENT}" "${HOME_DIR}/.${ENVIRONMENT}"
  source "${HOME_DIR}/.${ENVIRONMENT}"
  printf "Sourced environment variables successfully.\n"
else 
  printf "The Environment variable script (${BASH_DIR}/${ENVIRONMENT}) doesn't exist.\n"
fi

printf "\nThe dotfiles setup is now complete.\n"