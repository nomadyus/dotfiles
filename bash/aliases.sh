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
alias c="echo 'Running: cd'; cd "
alias -- -="echo 'Running cd -'; cd -"

## Git
alias gst="echo 'Running: git status'; git status "
alias gpr="echo 'Running: git pull --rebase'; git pull --rebase"
alias gpl="echo 'Running: git pull'; git pull "
alias gps="echo 'Running: git push'; git push "
alias gad="echo 'Running: git add .'; git add "
alias ga.="echo 'Running: git add .'; git add ."
alias gcm="echo 'Running: git commit -m'; git commit -m "
alias gca="echo 'Running: git commit --amend'; git commit --amend "
alias gco="echo 'Running: git commit '; git commit "
alias gc.="echo 'Running: git checkout .'; git checkout ."
alias gck="echo 'Running: git checkout'; git checkout "
alias gdf="echo 'Running: git diff'; git diff "
alias glo="echo 'Running: git log'; git log "

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
