#!/bin/sh
## Setup script for the terminal profile

## Adding color to the terminal
## Reference: https://github.com/sapegin/dotfiles/blob/bash/includes/bash_prompt.bash

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
promot_conda_symbol="🐍  "

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
	    venv_prompt=" $BLUE$promot_conda_symbol$(basename $CONDA_PREFIX)$NOCOLOR"
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
}

# Show awesome prompt only if Git is istalled
command -v git >/dev/null 2>&1 && PROMPT_COMMAND=promptCommand

# Install beatiful tmux
# Reference: https://gist.github.com/simme/1297707
installTmux