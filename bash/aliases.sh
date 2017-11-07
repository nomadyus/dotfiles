#!/bin/sh
## Setup for bash aliases

##  Navigation
alias d="echo 'Running: cd ~/Development'; cd ~/Development; pwd"
alias dev="echo 'Opening ~/Development'; cd ~/Development; pwd"
alias .="echo 'Running: pwd'; pwd"
alias ..="echo 'Running: cd ..'; cd ..; pwd"
alias ...="echo 'Running: cd ../..'; cd ../..; pwd"
alias ....="echo 'Running: cd ../../..'; cd ../../..; pwd"
alias .....="echo 'Running: cd ../../../..'; cd ../../../..; pwd"
alias ~="echo 'Running: cd ~'; cd ~; pwd"
alias c="echo 'Running: cd ~'; cd ~; pwd"
alias -- -="echo 'Running cd -'; cd -"

## Git
alias gst="echo 'Running: git status'; git status"
alias gpr="echo 'Running: git pull --rebase'; git pull --rebase"
alias ga.="echo 'Running: git add .'; git add ."
alias gcm="echo 'Running: git commit -m'; git commit -m"
alias gc.="echo 'Running: git checkout .'; git checkout ."
alias gdf="echo 'Running: git diff'; git diff"
alias gpf="echo 'Running: ../git/profile.sh';  ../git/profile.sh"

## Development
alias src="echo src='Sourcing ~/.bash_profile'; source ~/.bash_profile" 
alias hey="echo 'Read ~/.bash_profile'; cat ~/.bash_profile"
alias vib="echo 'Edit ~/.bash_profile' ; vi ~/.bash_profile"
alias lsa="echo 'Listing content in directory'; ls -la"
alias x="echo 'Making executable'; chmod +x "
alias x+="echo 'Making executable'; chmod +x "
alias -- +x="echo 'Making executable'; chmod +x "
alias ax="echo 'Making executable for all'; chmod a+x "
alias a+x="echo 'Making executable for all'; chmod a+x "
alias cl="echo 'Clearing Screen'; clear"
