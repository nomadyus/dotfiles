#!/bin/sh
## Git Profile Manager
# Given a Git profile (GitHub, Bitbucket, etc.) it updates the git config parameters appropriately.

BASE_DIR=$(dirname $_)

# Exit the script whenever there is an error
set -e

# Define usage function
programName=$0

function usage {
  echo "Git Profile Manager"
  echo "description: given a Git profile (GitHub, Bitbucket, etc.) it updates the git config parameters appropriately."
  echo "usage: $programName [profile]"
  echo "  [profile] the name of the profile to be used. One from 'telus', 'telus-digital', 'kami', 'bb' or 'gl'."
  exit 1
}

export GIT_PROFILE="$BASE_DIR/profile.sh"

# Invoke Usage function
[[ -z $1 || $1 == '--help' || $1 == 'help'  ]] && { usage; }

# Run script
printf "\nRunning Git Profile Manager.\n"

## Input Parameter(s)
# 1. Profile name to use to load configuration (one of: 'telus', 'kami' or 'bb').
PROFILE=${1:-}

function checkForGitDependency() {
  printf "Checking that you have Git installed.\n"
  if ! which git &> /dev/null
    then
      printf "I need Git installed to proceed!\n"
      exit 1
  fi
  printf "You got Git. Nice!\n"
}

function checkForGitRepository() {
  printf "Checking that the repository is Git compatible.\n"

  if [ -d .git ]; then
    printf "This location is a Git repository.\n"
  else
    printf "This is a NOT a Git repository.\n"
    exit 1
  fi
}

function checkForInputParameters() {
  printf "Checking which profile to run.\n"
  if [ -z "${PROFILE}" ]; then
    printf "No Git profile provided!\n"
    exit 1
  fi
  printf "Working with Git profile '${PROFILE}'.\n"
}

# Invoke usage function: call usage() function if profile name not supplied
[[ $# -eq 0 ]] && usage

checkForGitDependency

checkForGitRepository

checkForInputParameters

printf "Preparing to manage you Git profiles.\n"

REMOTE_ORIGIN=$(git config remote.origin.url)

if [ 'telus-digital' = "${PROFILE}" ]; then
  printf "Using the 'Telus Digital' Git profile.\n"
  git config user.name "Yusuf Fadairo"
  git config user.email "yusuf.fadairo@telus.com"
  REMOTE_ORIGIN=${REMOTE_ORIGIN/@github./@telus.github.}
  printf "\nRemote Origin ${REMOTE_ORIGIN}\n"

elif [ 'telus' = "${PROFILE}" ]; then
  printf "Using the 'Telus' Git profile.\n"
  git config user.name "Yusuf Fadairo"
  git config user.email "yusuf.fadairo@telus.com"
  REMOTE_ORIGIN=${REMOTE_ORIGIN/@telus.github./@github.}

elif [ 'kami' = "${PROFILE}" ]; then
  printf "Using the 'Yusuf Fadairo' Git profile.\n"
  git config user.name "Yusuf Fadairo"
  git config user.email "yusuf.kami@gmail.com"
  REMOTE_ORIGIN=${REMOTE_ORIGIN/@telus.github./@github.}

elif [ 'bb' = "${PROFILE}" ]; then
  printf "Using the 'Yusuf Fadairo' Bitbucket profile.\n"
  git config user.name "Yusuf Fadairo"
  git config user.email "yusuf.kami@gmail.com"

elif [ 'gl' = "${PROFILE}" ]; then
  printf "Using the 'Yusuf Fadairo' GitLab profile.\n"
  git config user.name "Yusuf Fadairo"
  git config user.email "yusuf.kami@gmail.com"
  git config user.signingkey 92A1AFEB8FF68EFA
  git config commit.gpgsign true

elif [ 'light' = "${PROFILE}" ]; then
  printf "Using the 'Yusuf Fadairo' profile for an Enlighten project.\n"
  git config user.name "Yusuf Fadairo (Enlighten)"
  git config user.email "contact@enlighten.ai"

else
  printf "Profile name provided is not recognised.\n"
  exit 1
fi

git config remote.origin.url $REMOTE_ORIGIN

printf "Your Git profile has been set.\n"

printf "\nYour Git global config is:\n"
git config --global --list

printf "\nYour Git config for the local repo is:\n"
git config --local --list

printf "\nProfile management completed successfully.\n"
