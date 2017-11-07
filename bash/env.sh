#!/bin/sh
## Setup for the Environment Variables

printf '\nMarking commander script\n'
export ENV_COMMAND=$0
export ENV_SET_BY_SCRIPT=true

printf '\nUsing NVM_DIR="$HOME/.nvm"\n'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

printf '\nUsing default Vault address\n'
echo 'Using: VAULT_ADDR=http://127.0.0.1:8200'
export VAULT_ADDR=http://127.0.0.1:8200

printf '\nSetting flag not to use New Relic config file\n'
export NEW_RELIC_NO_CONFIG_FILE=true