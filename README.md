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
echo "Storing the dotfiles path to ~/.bash_profile"
export DOTFILES_DIR=[PATH TO DOTFILES DIR]
alias dotfiles="pushd $(pwd); cd $DOTFILES_DIR; source ./dotfiles.sh; popd"

echo "Loading dotfiles"
dotfiles
```
In order to reload the dotfile you can simply source the file using the path in the environment variable with the command `dotfiles`.
Setting the `DOTFILES_DIR` environment variable also lets you set up an alias for the [Git Profile Manager](https://github.com/yusuf-kami/dotfiles/blob/master/git/profile.sh) by adding the following line to your `~/bash_profile`
```
alias gpf="echo 'Running: Git Profile Manager'; $DOTFILES_DIR/git/profile.sh "

```


## Included
The repository includes the following configuration and tools:
### Bash
#### [Aliases](https://github.com/yusuf-kami/dotfiles/blob/master/bash/aliases.sh)

### Git
#### [Git Profile Manager](https://github.com/yusuf-kami/dotfiles/blob/master/git/profile.sh)
The git profile manager sets the user name and email used to interface with GitHub or Bitbucket. It also sets the Hostname used to connect to GitHub for profiles that have more than one user accounts for the same provider.

