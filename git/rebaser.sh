#!/bin/sh
## Git Rebaser
# This goes through all directories recursively and performs a `git pull --rebase` command on all git directoies.

BASE_DIR=$(dirname $_)

# Exit the script whenever there is an error
set -e

# Define usage function
programName=$0

function usage {
  echo "Git Rebaser"
  echo "description: This goes through all directories recursively and performs a `git pull --rebase` command on all git directoies."
  echo "usage: $programName"
  exit 1
}

export GIT_REBASER="$BASE_DIR/rebaser.sh"

# Invoke Usage function
[ -z $1 ] && { usage; }

# Run script
printf "\nRunning Git Rebaser.\n"

function checkForGitDirectory() {

checkForGitDependency

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

checkForGitDirectory