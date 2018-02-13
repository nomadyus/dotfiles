#!/bin/sh
## Setup for bash aliases
## Complex functions
function printAllHistory() {
  for history in `echo ~/.bash_sessions/*`; do echo "Printing history in '$history' file"; while read -r line; do echo "$line"; done  < $history; done;
}

##  Navigation
alias d="echo 'Running: cd ~/Development'; cd ~/Development; pwd"
alias dev="echo 'Opening ~/Development'; cd ~/Development; pwd"
alias lsa="echo 'Listing content in directory'; ls -la"
alias .="echo 'Running: pwd'; pwd"
alias ..="echo 'Running: cd ..'; cd ..; pwd"
alias ...="echo 'Running: cd ../..'; cd ../..; pwd"
alias ....="echo 'Running: cd ../../..'; cd ../../..; pwd"
alias .....="echo 'Running: cd ../../../..'; cd ../../../..; pwd"
alias ~="echo 'Running: cd ~'; cd ~; pwd"
alias c="echo 'Running: cd'; cd "
alias l="echo 'Running: ls -a'; pwd; lsa;"
alias p="echo 'Running: pwd'; pwd;"
alias -- -="echo 'Running cd -'; cd -"

## Git
alias gst="echo 'Running: git status'; git status "
alias gsl="echo 'Running: git stash list'; git stash list"
alias gss="echo 'Running: git stash save'; git stash save "
alias gsa="echo 'Running: git stash apply'; git stash apply "
alias gsp="echo 'Running: git stash pop'; git stash pop "
alias gpr="echo 'Running: git pull --rebase'; git pull --rebase"
alias gpl="echo 'Running: git pull'; git pull "
alias gps="echo 'Running: git push'; git push "
alias gad="echo 'Running: git add'; git add "
alias ga.="echo 'Running: git add .'; git add ."
alias gcm="echo 'Running: git commit -m'; git commit -m "
alias gca="echo 'Running: git commit --amend'; git commit --amend "
alias gco="echo 'Running: git commit '; git commit "
alias gc.="echo 'Running: git checkout .'; git checkout ."
alias gck="echo 'Running: git checkout'; git checkout "
alias gdf="echo 'Running: git diff'; git diff "
alias glo="echo 'Running: git log'; git log "
alias gsh="echo 'Running: git show'; git show "
alias gll="echo 'Running: git log --oneline'; git log --oneline "
alias gl1="echo 'Running: git log -n1'; git log -n1"
alias gl2="echo 'Running: git log -n2'; git log -n2"
alias gl3="echo 'Running: git log -n3'; git log -n3"
alias gl4="echo 'Running: git log -n4'; git log -n4"
alias glg="echo 'Running: git log --grep'; git log --grep "
alias gcg="echo 'Running: git config --list'; git config --list"
alias gcl="echo 'Running: git config --local --list'; git config --local --list"
alias gtg="echo 'Running: git tag'; git tag"
alias gta="echo 'Running: git tag -a'; git tag -a "
alias gpt="echo 'Running: git push --tags'; git push --tags"
alias gbr="echo 'Running: git branch '; git branch "
alias gbd="echo 'Running: git branch -d'; git branch -d "
alias gmv="echo 'Running: git mv'; git mv "

## Development
alias mkd= "echo 'Making new directory'; mkdir "
alias src="echo src='Sourcing ~/.bash_profile'; source ~/.bash_profile"
alias hey="echo 'Read ~/.bash_profile'; cat ~/.bash_profile"
alias vib="echo 'Edit ~/.bash_profile' ; vi ~/.bash_profile"
alias x="echo 'Making executable'; chmod +x "
alias x+="echo 'Making executable'; chmod +x "
alias -- +x="echo 'Making executable'; chmod +x "
alias ax="echo 'Making executable for all'; chmod a+x "
alias a+x="echo 'Making executable for all'; chmod a+x "
alias cl="echo 'Clearing Screen'; clear; clear;"
alias his="echo 'Printing all history sessions'; printAllHistory"

## Docker
alias dim="echo 'Running: docker images'; docker images"
alias dia="echo 'Running: docker images'; docker images -a"
alias dps="echo 'Running: docker ps'; docker ps"
alias dpa="echo 'Running: docker ps'; docker ps -a"
alias dic="echo 'Running: docker rmi $(docker images -aq)'; docker rmi $(docker images -aq)"
alias dpc="echo 'Running: docker rm $(docker ps -aq)'; docker rm $(docker ps -aq)"

## Magic
alias ps="echo 'Running: ps aux'; ps aux"
alias psg="echo 'Running: ps aux | grep '; ps aux | grep "
alias pan="echo 'Get port of PID. Running lsof -Pan -p PID -i'; lsof -Pan -p PID -i "