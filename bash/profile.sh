#!/bin/sh
## Setup script for the terminal profile

## Adding color to the terminal
## Reference: https://github.com/sapegin/dotfiles/blob/bash/includes/bash_prompt.bash

printf '\nConfiguring the terminal display.\n'

# User color
case $(id -u) in
	0) user_color="$RED" ;;  # root
	*) user_color="$GREEN" ;;
esac

# Symbols
prompt_symbol="-❥"
prompt_clean_symbol="✿ "
prompt_dirty_symbol="☂ "
prompt_venv_symbol="☁ "
prompt_conda_symbol="🐍  "

function promptCommand() {
	# Local or SSH session?
	local remote=
	[ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] && remote=1

	# Git branch name and work tree status (only when we are inside Git working tree)
	local git_prompt=
	if [[ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]; then
		# Branch name
		local branch="$(git symbolic-ref HEAD 2>/dev/null)"
		branch="${branch##refs/heads/}"

		# Working tree status (red when dirty)
		local dirty=
		# Modified files
		git diff --no-ext-diff --quiet --exit-code --ignore-submodules 2>/dev/null || dirty=1
		# Untracked files
		[ -z "$dirty" ] && test -n "$(git status --porcelain)" && dirty=1

		# Format Git info
		if [ -n "$dirty" ]; then
			git_prompt=" $RED$prompt_dirty_symbol$branch$NOCOLOR"
		else
			git_prompt=" $GREEN$prompt_clean_symbol$branch$NOCOLOR"
		fi
	fi

	# Virtualenv
	local venv_prompt=
	if [ -n "$VIRTUAL_ENV" ]; then
	    venv_prompt=" $BLUE$prompt_venv_symbol$(basename $VIRTUAL_ENV)$NOCOLOR"
	fi

  # Conda environment
	local conda_prompt=
	if [ -n "$CONDA_PREFIX" ]; then
	    venv_prompt=" $BLUE$prompt_conda_symbol$(basename $CONDA_PREFIX)$NOCOLOR"
	fi

	# Only show username if not default
	local user_prompt=
	[ "$USER" != "$local_username" ] && user_prompt="$user_color$USER$NOCOLOR"

	# Show hostname inside SSH session
	local host_prompt=
	[ -n "$remote" ] && host_prompt="@$YELLOW$HOSTNAME$NOCOLOR"

	# Show delimiter if user or host visible
	local login_delimiter=
	[ -n "$user_prompt" ] || [ -n "$host_prompt" ] && login_delimiter=":"

	# Format prompt
	first_line="$user_prompt$host_prompt$login_delimiter$WHITE\w$NOCOLOR$git_prompt$venv_prompt"
	# Text (commands) inside \[...\] does not impact line length calculation which fixes stange bug when looking through the history
	# $? is a status of last command, should be processed every time prompt prints
	second_line="\`if [ \$? = 0 ]; then echo \[\$CYAN\]; else echo \[\$RED\]; fi\`\$prompt_symbol\[\$NOCOLOR\] "
	PS1="\n$first_line\n$second_line"

	# Multiline command
	PS2="\[$CYAN\]$prompt_symbol\[$NOCOLOR\] "

	# Terminal title
	local title="$(basename "$PWD")"
	[ -n "$remote" ] && title="$title \xE2\x80\x94 $HOSTNAME"
	echo -ne "\033]0;$title"; echo -ne "\007"
}

function installTmux() {
  if ! which brew &> /dev/null
    then
      printf "I need 'brew' to install 'tmux' and you don't have it!\n"
      exit 1
  fi

  if ! which tmux &> /dev/null
    then
      printf "The CLI for 'tmux' is not installed.\n"
      printf "We are installing 'tmux'!\n"
      # First install tmux
      brew install tmux

      # For mouse support (for switching panes and windows)
      # Only needed if you are using Terminal.app (iTerm has mouse support)
      # Install http://www.culater.net/software/SIMBL/SIMBL.php
      # Then install https://bitheap.org/mouseterm/

      # More on mouse support http://floriancrouzat.net/2010/07/run-tmux-with-mouse-support-in-mac-os-x-terminal-app/

      # Enable mouse support in ~/.tmux.conf
      #  set-option -g mouse-select-pane on
      #  set-option -g mouse-select-window on
      #  set-window-option -g mode-mouse on

      # Install Teamocil to pre define workspaces
      # https://github.com/remiprev/teamocil

      # See http://files.floriancrouzat.net/dotfiles/.tmux.conf for configuration examples
  else
    printf "You already have 'tmux' installed!\n"
  fi

  # Setup Tmux key bindings
  printf "Setting up tmux key bindings!\n"
  tmux bind -n C-k send-keys -R \; send-keys C-l \; clear-history
  tmux bind % split-window -c "#{pane_current_path}"
}

function installTools() {
  if ! which brew &> /dev/null
    then
      printf "I need 'brew' to install the Tools and you don't have it!\n"
      exit 1
  fi

  if [ ! -d ~/.nvm ];
    then
      printf "The CLI for 'nvm' is not installed.\n"
      printf "We are installing 'nvm'!\n"
      brew install nvm
  else
    printf "You already have 'nvm' installed!\n"
  fi

  if ! which vault &> /dev/null
    then
      printf "The CLI for 'vault' is not installed.\n"
      printf "We are installing 'vault'!\n"
      brew install vault
  else
    printf "You already have 'vault' installed!\n"
  fi

  if ! which tfenv &> /dev/null
    then
      printf "The CLI for 'tfenv' is not installed.\n"
      printf "First unlinking installed 'terraform' versions before installing 'tfenv'!\n"
      brew unlink terraform
      printf "We are installing 'tfenv' for managing 'terraform' versions!\n"
      brew install tfenv
  else
    printf "You already have 'vault' installed!\n"
  fi

  if ! which clj &> /dev/null
    then
      printf "The 'clj' runtime is not installed.\n"
      printf "We are installing 'clojure'!\n"
      brew install clojure/tools/clojure
  else
    printf "You already have 'clj' installed!\n"
  fi

  if ! which lein &> /dev/null
    then
      printf "The 'lein' runtime is not installed.\n"
      printf "We are installing 'lein' via 'leiningen'!\n"
      brew install leiningen
  else
    printf "You already have 'lein' installed!\n"
  fi

  # Install 'conda' to enable working with Python environments
  if ! which conda &> /dev/null
    then
      printf "We are installing 'conda'!\n"
      brew install --cask miniconda
    else
      printf "You already have 'conda' installed!\n"
  fi

  # Install 'travis' to enable project build and CI
  if ! which travis &> /dev/null
    then
      printf "We are installing 'travis'!\n"
      brew install travis
    else
      printf "You already have 'travis' installed!\n"
  fi
}

function installUtils() {
  if ! which brew &> /dev/null
    then
      printf "I need 'brew' to install the Utilities and you don't have it!\n"
      exit 1
  fi

  printf "Installing some utilities with 'brew'.\n"
  # Install 'watch' to continuously check results of a command
  if ! which watch &> /dev/null
    then
      printf "We are installing 'watch'!\n"
      brew install watch
    else
      printf "You already have 'watch' installed!\n"
  fi
  # Install 'htop' for resource monitoring
  if ! which htop &> /dev/null
    then
      printf "We are installing 'htop'!\n"
      brew install htop
    else
      printf "You already have 'htop' installed!\n"
  fi
  # Install 'wget' for ftp or http data download
  if ! which wget &> /dev/null
    then
      printf "We are installing 'wget'!\n"
      brew install wget
    else
      printf "You already have 'wget' installed!\n"
  fi
  # Install 'nmap' for network security
  if ! which nmap &> /dev/null
    then
      printf "We are installing 'nmap'!\n"
      brew install nmap
    else
      printf "You already have 'nmap' installed!\n"
  fi
  # Install 'links' for command line browsing
  if ! which links &> /dev/null
    then
      printf "We are installing 'links'!\n"
      brew install links
    else
      printf "You already have 'links' installed!\n"
  fi
  # Install 'geoip' for geolocation lookup
  if ! which geoiplookup &> /dev/null
    then
      printf "We are installing 'geoip'!\n"
      brew install geoip
    else
      printf "You already have 'geoip' ('geoiplookup') installed!\n"
  fi
  # Install 'firebase' for firebase CLI
  if ! which geoiplookup &> /dev/null
    then
      printf "We are installing 'firebase'!\n"
      curl -sL https://firebase.tools | bash
    else
      printf "You already have 'firebase' installed!\n"
  fi
  # Install 'aws' for AWS CLI
  if ! which geoiplookup &> /dev/null
    then
      printf "You need to install 'aws'!\n"
      open https://aws.amazon.com/cli/
    else
      printf "You already have 'aws' installed!\n"
  fi
  # Install 'gcloud' for Google Cloud CLI
  if ! which geoiplookup &> /dev/null
    then
      printf "You need to install 'gcloud'!\n"
      open https://cloud.google.com/sdk/docs/install
    else
      printf "You already have 'gcloud' installed!\n"
  fi
  # Install 'sbt' for Scala Building and Packaging
  if ! which sbt &> /dev/null
    then
      printf "You need to install 'sbt'!\n"
      brew install sbt
    else
      printf "You already have 'sbt' installed!\n"
  fi

}

# Show awesome prompt only if Git is istalled
command -v git >/dev/null 2>&1 && PROMPT_COMMAND=promptCommand
command -v git >/dev/null 2>&1 && PROMPT='%B%F{green}%n%F{nocolor}%b:%~ %F{cyan}%B-❥%b%F{nocolor} '

# Install beatiful tmux
# Reference: https://gist.github.com/simme/1297707
installTmux

# Install some tools
installTools

# Install some utilities
installUtils