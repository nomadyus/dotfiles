# dotfiles
A collection of scripts and code snippets used for most of my development.

## Installation
$ git clone https://github.com/yusuf-kami/dotfiles.git ~/dotfiles
$ cd ~/dotfiles
$ chmod +x dotfiles.sh
$ source ./dotfiles.sh 

## Setup
Setting up the dotfiles is as easy as `source ./dotfiles.sh ` in any bash environment. 

## Reloading
The setup will also create a path to the `./dotfiles.sh` file using the environment variable `DOTFILES`. You can always reload the dotfiles by using the environment variable with the command `source $DOTFILES`.

## Included
The repository includes the following configuration and tools:
### Bash
- [Aliases](https://github.com/yusuf-kami/dotfiles/blob/master/bash/aliases.sh)

### Git
- [Git Profile Manager](https://github.com/yusuf-kami/dotfiles/blob/master/git/profile.sh)

