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
Add the path of the directory to `/.dotfiles.sh` file to your `~/bash_profile` using the environment variables `DOTFILES_DIR` like below:
```
#~/.bash_profile
echo "Storing the dotfiles path to .bash_profile"
export DOTFILES_DIR=~/Development/kami/dotfiles
alias dotfiles="DIR=$(pwd); cd $DOTFILES_DIR; source ./dotfiles.sh; cd $DIR"
```
In order to reload the dotfile you can simply source the file using the path in the environment variable with the command `dotfiles`.


## Included
The repository includes the following configuration and tools:
### Bash
- [Aliases](https://github.com/yusuf-kami/dotfiles/blob/master/bash/aliases.sh)

### Git
- [Git Profile Manager](https://github.com/yusuf-kami/dotfiles/blob/master/git/profile.sh)

