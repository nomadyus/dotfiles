#!/bin/sh
## Git Rebaser
# This goes through all directories recursively startin from the current one and performs a 'git pull --rebase' command on all Git directoies.

BASE_DIR=$(dirname $_)

# Exit the script whenever there is an error
set -e

# Define usage function
programName=$0

function usage {
  echo "Git Rebaser"
  echo "description: This goes through all directories recursively and performs a 'git pull --rebase' command on all Git directoies."
  echo "usage: $programName"
  exit 1
}

export GIT_REBASER="$BASE_DIR/rebaser.sh"

# Invoke Usage function
[[ $1 == '--help' || $1 == 'help' ]] && { usage; }

# Run script
printf "\nRunning Git Rebaser.\n"

function checkForGitDependency() {
  printf "Checking that you have Git installed.\n"
  if ! which git &> /dev/null
    then
      printf "I need Git installed to proceed!\n"
      exit 1
  fi
  printf "You got Git. Nice!\n"
}

function checkForGitDirectory() {

for item in `echo *`;
  do
  echo "Checking '$item' is a git directory.";

  if [ $item == "node_modules" ] || [ $item == ".DS_Store" ] || [ $item == "build" ] || [ $item == "dist" ] || [ $item == "cache" ]; then
    echo "Ignoring $PWD/$item and moving on."

    elif [ -d "$PWD/$item/" ]; then
      echo "$PWD/$item is a regular directory. Performing recursion on it."
      cd $item
      checkForGitDirectory
      cd ..
      echo "Done with directory."

    elif [ -d "$PWD/$item/.git" ]; then
      echo "$PWD is a git directory. We can perform a `git pull --rebase` command."
      echo "Performing `git pull --rebase` command."
      echo "Rebase completed."

    else
      echo "$PWD/$item is just a file."
  fi
done;
}

checkForGitDependency

checkForGitDirectory