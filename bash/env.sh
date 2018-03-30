#!/bin/sh
## Setup for the Environment Variables

printf '\nMarking commander script.\n'
export ENV_COMMAND=$0
export ENV_SET_BY_SCRIPT=true

printf '\nUsing default Vault address.\n'
echo 'Using: VAULT_ADDR=http://127.0.0.1:8200'
export VAULT_ADDR=http://127.0.0.1:8200

printf '\nSetting flag to not use New Relic config file.\n'
export NEW_RELIC_NO_CONFIG_FILE=true

## Export properties for the terminal settings
# Locale
export LC_ALL=en_US.UTF-8
export LANG="en_US"

# Colors
RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
MAGENTA="$(tput setaf 5)"
CYAN="$(tput setaf 6)"
WHITE="$(tput setaf 7)"
GRAY="$(tput setaf 8)"
BOLD="$(tput bold)"
UNDERLINE="$(tput sgr 0 1)"
INVERT="$(tput sgr 1 0)"
NOCOLOR="$(tput sgr0)"

# Tell ls to be colourful
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

# File system color scheme
export LSCOLORS=Gxfxcxdxbxegedabagacad