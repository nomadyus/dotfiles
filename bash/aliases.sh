#!/bin/sh
## Setup for bash aliases

## View all commands that have been executed in all sessions.
function printAllHistory() {
  for history in `echo ~/.bash_sessions/*`;
    do echo "Printing history in '$history' file";
    while read -r line;
      do echo "$line";
    done < $history;
  done;
}

## Get the port that an application process is running on.
function getPort() {
  echo "Get port of process with PID '$1'."
  echo "Running lsof -Pan -p $1 -i"
  lsof -Pan -p $1 -i
}

## Get the PID of TCP process running on a port.
function getPid() {
  echo "Get PID of TCP process serving on the port '$1'."
  echo "Running sudo lsof -i tcp:$1"
  lsof -i tcp:$1
}

## Build a directory structure using the output of the find command.
function unfind() {
	while read -r item;
		do
		if [[ $item == *"__MACOSX"* ]]; then
    		echo "Ignoring '$item' and moving on."
    	elif [[ $item =~ ^(.*)(\.[a-z]{1,9})$ ]]; then
    		echo "Entry '$item' is a file";
		else
			echo "Making directory '$PWD/$item'"
			mkdir -pv "$PWD/$item"
		fi
	done;
}

## Print the disk usage for file and folders in current directory.
function folderSize() {
  for item in `echo *`;
  do
    if [[ -d $item ]]; then
      cd $item;
      echo "Folder /$item size: $(du -sh)";
      cd ..;
    else
      echo "File size: $(du -sh $item)";
    fi
  done;
}

## Print a string of characters multiple times
function printfMultiple() {
 string=$1
 times=$2
 times=${times:-1}
 operation="%1.s${string}."
 printf $operation $(eval echo {1..$times})
}

## Check the current child directories for a build.xml file
## If the file is found use ant to build the project
function buildFolderWithAnt() {
  ## TODO: It shoudl check that we have ant installed first
  for file in `echo *`;
  do
    if [ -d $file ]; then
      echo "Checking directory for build.xml file.";
      cd $file;
      if [ -e "$PWD/build.xml" ]; then
        echo "There is a build.xml file.";
        echo "Building project \"$file\" with Ant.";
        ant;
      fi
      cd ..;
    fi
  done;
}

## Kill all process that match name
function killProcess() {
  name=$1
  ps -aux | grep "$name" | awk '{ print $2 }' | grep -o '[0-9]\+' | awk '{ system ("echo Killing process " $1 "; kill -9 " $1) }'
}

## Clean Docker images
function dockerImageClean() {
  docker images -a | awk '{ system(" echo \"Cleaning image: \"" $3  "; docker rmi -f " $3) }'
}

## Clean Docker processes
function dockerProcClean() {
  docker ps -a | awk '{ system(" echo \"Cleaning process: \"" $1 "; docker rm -f " $1 ) }'
}

function parse_creds() {
  local creds=$1
  local attribute=.Credentials.$2

  echo $creds | jq $attribute | tr -d '"'
}

## Get AWS credentials with MFA token and set to environment variable
function refreshAwsMfa() {
  if [[ "$1" == "" || "$2" == ""  ]]; then
    echo 'Usage: mfa [AWS-PROFILE] [MFA TOKEN CODE]'
    return
  fi

  local profile=$1
  local mfa=$2

  creds=$(aws sts get-session-token --serial-number $MFA_DEVICE_ARN --token-code $mfa --profile $profile)
  if [[ -n "$creds" ]]; then
    echo 'Parsing cedentials for profile '$profile'...'
    local AWS_ACCESS_KEY_ID=$(parse_creds "$creds" "AccessKeyId")
    local AWS_SECRET_ACCESS_KEY=$(parse_creds "$creds" "SecretAccessKey")
    local AWS_SESSION_TOKEN=$(parse_creds "$creds" "SessionToken")
    if [[ -n "$AWS_ACCESS_KEY_ID" ]]; then
        export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
        export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
        export AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN
        echo 'AWS credentials exported to following environment variables: AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, AWS_SESSION_TOKEN'
        echo "Copy the following into '~/.aws/credentials' for the AWS profile '$profile-mfa'"
        echo aws_access_key_id=$AWS_ACCESS_KEY_ID
        echo aws_secret_access_key=$AWS_SECRET_ACCESS_KEY
        echo aws_session_token=$AWS_SESSION_TOKEN
    fi
  fi
}

##  Navigation
alias b="echo 'Running: cd ~/Documents'; cd ~/Documents; pwd"
alias d="echo 'Running: cd ~/Development'; cd ~/Development; pwd"
alias dev="echo 'Opening ~/Development'; cd ~/Development; pwd"
alias lsa="echo 'Running ls -la'; pwd; ls -la -GFlash"
alias ..="echo 'Running: cd ..'; cd ..; pwd"
alias ...="echo 'Running: cd ../..'; cd ../..; pwd"
alias ....="echo 'Running: cd ../../..'; cd ../../..; pwd"
alias .....="echo 'Running: cd ../../../..'; cd ../../../..; pwd"
alias ~="echo 'Running: cd ~'; cd ~; pwd"
alias c="echo 'Running: cd'; cd "
alias l="echo 'Running: lsa'; lsa "
alias p="echo 'Running: pwd'; pwd"
alias -- -="echo 'Running cd -'; cd -"

## Git
alias gst="echo 'Running: git status'; git status "
alias gsl="echo 'Running: git stash list'; git stash list"
alias gss="echo 'Running: git stash save'; git stash save "
alias gsa="echo 'Running: git stash apply'; git stash apply "
alias gsp="echo 'Running: git stash pop'; git stash pop "
alias gsd="echo 'Running: git stash drop'; git stash drop "
alias gpr="echo 'Running: git pull --rebase'; git pull --rebase "
alias grb="echo 'Running: git rebase'; git rebase "
alias gft="echo 'Running: git fetch'; git fetch "
alias gfo="echo 'Running: git fetch origin'; git fetch origin "
alias gpl="echo 'Running: git pull'; git pull "
alias gps="echo 'Running: git push'; git push "
alias gpp="echo 'Running: git push --force'; git push --force"
alias gad="echo 'Running: git add'; git add "
alias gap="echo 'Running: git add . -p'; git add . -p "
alias ga.="echo 'Running: git add .'; git add ."
alias gcm="echo 'Running: git commit -m'; git commit -m "
alias gca="echo 'Running: git commit --amend'; git commit --amend "
alias gam="echo 'Running: git commit -am'; git commit -am "
alias gco="echo 'Running: git commit'; git commit "
alias gc.="echo 'Running: git checkout .'; git checkout ."
alias grm="echo 'Running: git rm'; git rm "
alias gck="echo 'Running: git checkout'; git checkout "
alias gdf="echo 'Running: git diff'; git diff "
alias gds="echo 'Running: git diff --staged'; git diff --staged "
alias glo="echo 'Running: git log'; git log "
alias gsh="echo 'Running: git show'; git show "
alias gsn="echo 'Running: git show --name-only'; git show --name-only"
alias gll="echo 'Running: git log --oneline'; git log --oneline "
alias gl1="echo 'Running: git log -n1'; git log -n1"
alias gl2="echo 'Running: git log -n2'; git log -n2"
alias gl3="echo 'Running: git log -n3'; git log -n3"
alias gl4="echo 'Running: git log -n4'; git log -n4"
alias gl5="echo 'Running: git log -n5'; git log -n5"
alias gl6="echo 'Running: git log -n6'; git log -n6"
alias gl7="echo 'Running: git log -n7'; git log -n7"
alias gl8="echo 'Running: git log -n8'; git log -n8"
alias gl9="echo 'Running: git log -n9'; git log -n9"
alias gl10="echo 'Running: git log -n10'; git log -n10"
alias glg="echo 'Running: git log --grep'; git log --grep "
alias gln="echo 'Running: git log --name-only'; git log --name-only "
alias gcg="echo 'Running: git config --list'; git config --list"
alias gcl="echo 'Running: git config --local --list'; git config --local --list"
alias gtg="echo 'Running: git tag'; git tag"
alias gta="echo 'Running: git tag -a'; git tag -a "
alias gpt="echo 'Running: git push --tags'; git push --tags"
alias gbr="echo 'Running: git branch '; git branch "
alias gbd="echo 'Running: git branch -d'; git branch -d "
alias gmv="echo 'Running: git mv'; git mv "
alias grl="echo 'Running: git reflog'; git reflog "
alias grt="echo 'Running: git reset '; git reset "
alias grs="echo 'Running: git reset '; git reset "
alias grh="echo 'Running: git reset HEAD --hard'; git reset HEAD --hard"
alias gcn="echo 'Running: git clone'; git clone "
alias gcd="echo 'To commit using past dates use the command: git commit --date=\"YYYY-MM-DD HH:MM:SS\"'"
alias grv="echo 'Running: git revert'; git revert "
alias gmg="echo 'Running: git merge'; git merge "
alias gms="echo 'Running: git merge --squas'; git merge --squash "
alias gcp="echo 'Running: git cherry-pick'; git cherry-pick "

## Development
alias e="echo 'Running: env'; env"
alias m="echo 'Running: mv'; mv "
alias mkd="echo 'Running: mkdir'; mkdir "
alias rmd="echo 'Running: rm -rf'; rm -rf "
alias src="echo 'Sourcing ~/.bash_profile'; source ~/.bash_profile"
alias hey="echo 'Read ~/.bash_profile'; cat ~/.bash_profile"
alias vib="echo 'Edit ~/.bash_profile' ; vi ~/.bash_profile"
alias x="echo 'Making file executable. Running: chmod +x'; chmod +x "
alias x+="echo 'Making file executable. Running: chmod +x'; chmod +x "
alias -- +x="echo 'Making file executable. Running: chmod +x'; chmod +x "
alias ax="echo 'Making executable for all. Running: chmod a+x'; chmod a+x "
alias a+x="echo 'Making executable for all. Running: chmod a+x'; chmod a+x "
alias cl="echo 'Clearing Screen'; clear; clear;"
alias clr="echo 'Clearing Screen'; clear; clear;"
alias his="echo 'Printing all history sessions'; printAllHistory"
alias s="echo 'Running: source'; source "
alias v="echo 'Running: vi'; vi "
alias r="echo 'Running: cat'; cat "
alias t="echo 'Running: tail'; tail "
alias les="echo 'Running: less'; less "
alias taf="echo 'Running: tail -f'; tail -f "
alias tac="echo 'Running: tar -zcvf'; tar -zcvf "
alias tuc="echo 'Running: tar -zxvf'; tar -zxvf "
alias kil="echo 'Running: kill -9'; kill -9 "
alias siz="echo 'Printing directory size'; du -sh "
alias cpd="echo 'Copying directory'; cp -r -f "
alias mfa="refreshAwsMfa "
alias eel="echo 'Deactivating Conda environment'; conda deactivate;"
alias snake2="echo 'Switching to Python 2.7'; conda deactivate; conda activate snake2;"
alias snake3="echo 'Switching to Python 3.7'; conda deactivate; conda activate snake3;"
alias snake3.5="echo 'Switching to Python 3.5'; conda deactivate; conda activate snake3.5;"
alias jdk="echo 'Sourcing SDK Man'; source ~/.sdkman/bin/sdkman-init.sh"

## Docker
alias dim="echo 'Running: docker images'; docker images"
alias dip="echo 'Running: docker image prune'; docker image prune --all --force"
alias dia="echo 'Running: docker images'; docker images -a"
alias dps="echo 'Running: docker ps'; docker ps"
alias dpc="echo 'Running: docker process clean '; dockerProcClean "
alias dpa="echo 'Running: docker ps'; docker ps -a"
alias dri="echo 'Running: docker rmi'; docker rmi "
alias drp="echo 'Running: docker rm'; docker rm "
alias dsp="echo 'Running: docker stop '; docker stop "
alias dcp="echo 'Running: docker-compose'; docker-compose "
alias dbd="echo 'Running: docker build '; docker build "
alias db.="echo 'Running: docker build .'; docker build ."
alias drn="echo 'Running: docker run'; docker run "
alias dkl="echo 'Running: docker kill'; docker kill "
alias dlo="echo 'Running: docker logs'; docker logs "
alias dlf="echo 'Running: docker logs --follow'; docker logs --follow "
alias dex="echo 'Running: docker exec -it '; docker exec -it "
alias dcl="echo 'Running: docker-compose logs '; docker-compose logs "
alias dst="echo 'Running: docker stats '; docker stats "

## Process
alias psa="echo 'Running: ps aux'; ps aux "
alias psg="echo 'Running: ps aux | grep '; ps aux | grep "
alias pan="echo 'Running get port for process'; getPort "
alias prt="echo 'Running port scan'; sudo lsof -i -P -n "
alias pid="echo 'Running get PID for port'; getPid "

## Application Databases
alias mongo-cli="docker exec -it MongoDB /bin/bash -c \"mongo \" "
alias sql-cli="docker exec -it SQLServer /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P Password1 "
alias orcl-cli="docker exec -it OracleDB /bin/bash -c \"source /home/oracle/.bashrc; sqlplus /nolog \" "
alias psql-cli="docker exec -it PostgreSQL psql -U postgres "
alias redis-server="docker pull redis; docker run --name redis-server -v ~/Development/mount/redis:/data -p 6379:6379 -d redis redis-server --save 60 1 --loglevel warning"
alias redis-host="docker exec redis-server hostname -I"
alias redis-cli="docker run -it --rm redis redis-cli -h \$(redis-host)"