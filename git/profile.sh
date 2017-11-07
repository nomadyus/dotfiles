#!/bin/sh
## Git Profile Manager
# Given a Git profile (GitHub, Bitbucket, etc.) it sets the git config parameters appropriately
set -e

# Define usage function
programName=$0

function usage {
  echo "Git Profile Manager"
  echo "description: given a Git profile (GitHub, Bitbucket, etc.) it sets the git config parameters appropriately."
  echo "usage: $programName [profile]"
  echo "  [profile]   the name of the profile to used. One of 'telus', 'kami' and 'bb'"
  exit 1
}

# Alias file in ~/.bashrc
BASHRC='~/.bashrc'
touch $BASHRC
echo "alias gpf $(pwd)/profile.sh" > $BASHRC
source $BASHRC

# Invoke Usage function
[ -z $1 ] && { usage; }

# Run script
printf "\nRunning Git Profile Manager.\n"

## Input Parameter(s)
# 1. Profile name [telus, kami, bb]
PROFILE=${1:-}

# When i tell you to use a profile for git 
# You should so do and use the same profile until I ask for it to be changed
# Do this by setting the user.name and user.email in git config

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

# invoke usage
# call usage() function if filename not supplied
[[ $# -eq 0 ]] && usage

checkForGitDependency

checkForGitRepository

checkForInputParameters

printf "Preparing to manage you Git profiles.\n"

if [ 'telus' = "${PROFILE}" ]; then
  printf "Using the 'Telus Digital' Git profile.\n"
  git config user.name "Yusuf Fadairo"
  git config user.email "yusuf.fadairo@telus.com"

elif [ 'kami' = "${PROFILE}" ]; then
  printf "Using the 'Yusuf Fadairo' Git profile.\n"
  git config user.name "Yusuf Fadairo"
  git config user.email "yusuf.kami@gmail.com"

elif [ 'bb' = "${PROFILE}" ]; then
  printf "Using the 'Yusuf Kami' Bitbucket profile.\n"
  git config user.name "Yusuf Kami"
  git config user.email "yusuf.kami@gmail.com"

else 
  printf "Profile name not recognised.\n"
  exit 1
fi

printf "Your Git profile has been set.\n"

printf "\nYour Git global config is:\n"
git config --global --list

printf "\nYour Git config for your local repo is:\n"
git config --local --list

printf "\nProfile management completed successfully.\n"