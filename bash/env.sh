#!/bin/sh
## Setup for the Environment Variables

echo 'Marking commander script'
export ENV_COMMAND=$0
export ENV_SET_BY_SCRIPT=true

echo 'Using NVM_DIR="$HOME/.nvm"'
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

echo 'Using default Vault address'
echo 'Using: VAULT_ADDR=http://127.0.0.1:8200'
export VAULT_ADDR=http://127.0.0.1:8200

echo 'Do not use New Relic config file'
export NEW_RELIC_NO_CONFIG_FILE=true