#!/bin/sh
# Should be linked with .git/hooks/pre-push
# You can pferform the symlink with the command:
#   rm .git/hooks/*
#   ln -fsv "$(PWD)/git/pre-push" .git/hooks/pre-push

# Exit immediately if a command exits with a non-zero status.
set -e

PATH=$PATH:/usr/local/bin:/usr/local/sbin
TEST_PATH=./src
FUNCTIONAL_TEST_PATH=./functional-test

printf "\nRunning pre-push hook...\n\n"

checkForOnlys() {
    if grep --quiet --recursive --exclude-dir=node_modules '\.only(' "$1"; then
      echo 'Oh poop! ".only" found on tests, please remove before pushing:\n'
      grep -H --line-number --recursive --exclude-dir=node_modules '\.only' "$1" | awk '{print "💩 " $0}'
      echo
      exit 1
    fi
}

checkForOnlys $TEST_PATH
checkForOnlys $FUNCTIONAL_TEST_PATH

npm install
npm test
