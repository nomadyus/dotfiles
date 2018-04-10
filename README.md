# dotfiles
A collection of scripts and code snippets used for most of my development.

## Installation
In order to install the `dotfiles` CLI use the following commands:
```
 git clone https://github.com/yusuf-kami/dotfiles.git ~/dotfiles
 cd ~/dotfiles
 chmod +x dotfiles.sh
 source ./dotfiles.sh
```

## Setup
Setting up the dotfiles is as easy as `source ./dotfiles.sh ` in any bash environment.

## Reloading
Add the path of the directory to `./dotfiles.sh` file to your `~/.bash_profile` using the environment variables `DOTFILES_DIR` like below:
```
#~/.bash_profile
echo "Storing the dotfiles path to ~/.bash_profile"
export DOTFILES_DIR=[PATH_TO_DOTFILES_DIR]
alias dotfiles="pushd $(pwd); cd $DOTFILES_DIR; source ./dotfiles.sh; popd"

echo "Loading dotfiles"
dotfiles
```
In order to reload the dotfile you can simply source the file using the path in the environment variable with the command `dotfiles`.
Setting the `DOTFILES_DIR` environment variable also lets you set up an alias for the [Git Profile Manager](https://github.com/yusuf-kami/dotfiles/blob/master/git/profile.sh) by adding the following line to your `~/.bash_profile`
```
alias gpf="echo 'Running: Git Profile Manager'; $DOTFILES_DIR/git/profile.sh "

```


## Included
The repository includes the following configuration and tools:
### Bash
#### Aliases
This **[`/bash/aliases.sh`](https://github.com/yusuf-kami/dotfiles/blob/master/bash/aliases.sh)** bash script contains all the aliases for the most frequently used commands and sets them for the console.
#### Profile
The bash profile script at **[`/bash/profile.sh`](https://github.com/yusuf-kami/dotfiles/blob/master/bash/profile.sh)** is also included to setup the profile and display preference for the terminal.

#### Theme
A theme for the bash console I really like called [Dracula](https://draculatheme.com/) is also included.
- You can set up the terminal theme by importing the [profile](https://github.com/yusuf-kami/dotfiles/blob/master/bin/Dracula.terminal) in file `./bin/Dracula.terminal` into the **Terminal**.
- For **iTerm2** you will have to import the [color presets](https://github.com/yusuf-kami/dotfiles/blob/master/bin/Dracula.terminal) in `./bin/Dracula.terminal` into the a new profile and apply it to the console.

These profiles can always be adjusted to your preferences once they are downloaded. The current look of the *Dracula* theme on Terminal is as follows:
![Dracula theme in Terminal](https://github.com/yusuf-kami/dotfiles/blob/master/bin/Dracula.png)


### Git
#### Git Profile Manager
The Git Profile Manager at **[`/git/profile.sh`](https://github.com/yusuf-kami/dotfiles/blob/master/git/profile.sh)** sets the user name and email used to interface with GitHub or Bitbucket. It also sets the Hostname used to connect to GitHub for profiles that have more than one user accounts for the same provider.
In order to be able to use the Git Profile Manager you must set up the alias in your `~/.bash_profile` with the following additions:
```
alias gpf="echo 'Running: Git Profile Manager'; $DOTFILES_DIR/git/profile.sh "

```
The manager can then be run using the `gpf` command in the console.

#### Git Rebaser
Included is also a Git Rebaser at **[`/git/rebaser.sh`](https://github.com/yusuf-kami/dotfiles/blob/master/git/rebaser.sh)** that is able to find all the Git directories in the system and performs a `git pull --rebase` command on all the directories.
In order to enable the Rebaser you can add the following alias in the `~/.bash_profile` file:
```
alias grb="echo 'Running: Git Rebaser'; $DOTFILES_DIR/git/rebaser.sh "

```
The Rebaser can then be run using the `grb` command in the console.
