#!/bin/sh
# Should be linked with .git/hooks/commit-msg
printf "\nValidating commit message format...\n\n"

# Regex for the commit message
commit_message_regex='^\s-[[:digit:]]{3,4}\s-\s\w+(\s&\s\w+)?:\s.+$'

if ! grep -Eq "$commit_message_regex" "$1"; then
cat << EOF >&2

Invalid commit message format

Actual:   $(head -1 "$1")
Expected: $(cat ./git/commit.template)

EOF
  exit 1
fi
