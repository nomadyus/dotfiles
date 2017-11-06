#!/bin/sh
# Should be linked with .git/hooks/pre-push
set -e
PATH=$PATH:/usr/local/bin:/usr/local/sbin
TEST_PATH=./src
FUNCTIONAL_TEST_PATH=./functional-test
printf "\nRunning pre-push hook...\n\n"

check_for_onlys() {
    if grep --quiet --recursive --exclude-dir=node_modules '\.only(' "$1"; then
      echo 'Oh poop! .only found on tests, please remove before pushing:\n'
      grep -H --line-number --recursive --exclude-dir=node_modules '\.only' "$1" | awk '{print "💩 " $0}'
      echo
      exit 1
    fi
}

check_for_onlys $TEST_PATH
check_for_onlys $FUNCTIONAL_TEST_PATH

npm install
npm test
