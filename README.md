# dotfiles
A collection of scripts and code snippets used to set up and startup the development environment and terminal profiles.

## tl;dr
```
 source ./dotfiles.sh
```

## Installation
In order to use `dotfiles` CLI you must first get the source from its GitHub [repo](https://github.com/yusuf-kami/dotfiles) with the following commands:
```
 git clone https://github.com/yusuf-kami/dotfiles.git dotfiles
 cd dotfiles
 chmod +x ./dotfiles.sh
 source ./dotfiles.sh
```


## Setup
Setting up the dotfiles is as easy as the command `source ./dotfiles.sh` in any linux-based shell environment.


## Reloading
Add the path of the directory for `./dotfiles.sh` file to the environment variables `DOTFILES_DIR` and add the following lines to your shell profile script (for `bash`: either `~/.profile` on Debian/Ubuntu or `~/.bash_profile` on CentOS/Fedora/RedHat or `~/.bashrc` on other Linux systems; for `zshell` use `~/.zshrc`)

```
  #~/.bash_profile
  echo "Storing the dotfiles path to ~/.bash_profile"
  export DOTFILES_DIR=[PATH_TO_DOTFILES_DIR]
  alias dotfiles="pushd '$(pwd)' > /dev/null; cd $DOTFILES_DIR; source ./dotfiles.sh; popd  > /dev/null;"

  echo "Loading dotfiles"
  dotfiles
  echo "Completed dotfiles installation. You are ready to go \"Beast Mode\"!"
```

In order to reload the dotfile you can simply source the file using the path in the environment variable with the command `dotfiles`.
Setting the `DOTFILES_DIR` environment variable also lets you set up an alias for the [Git Profile Manager](https://github.com/yusuf-kami/dotfiles/blob/master/git/profile.sh) by adding the following line to your `~/.bash_profile`

```
$ alias gpf="echo 'Running: Git Profile Manager'; $DOTFILES_DIR/git/profile.sh "
```


## Included
The repository includes the following configuration and tools:
### 1. Bash
#### 1.1. Aliases
This **[`/bash/aliases.sh`](https://github.com/yusuf-kami/dotfiles/blob/master/bash/aliases.sh)** bash script contains all the aliases for the most frequently used commands and sets them for the console.
**NOTE**: It might be helpful to determine the *code* or *script* attached to an *alias* or a *command*. In order to determine the scripts attached to a command/alias use the  command `type` on the command/alias in question.

#### 1.2. Profile
The bash profile script at **[`/bash/profile.sh`](https://github.com/yusuf-kami/dotfiles/blob/master/bash/profile.sh)** is also included to setup the profile and display preference for the terminal.

#### 1.3. Theme
A theme for the bash console I really like called [Dracula](https://draculatheme.com/) is also included.
- You can set up the terminal theme by importing the [profile](https://github.com/yusuf-kami/dotfiles/blob/master/bin/Dracula.terminal) in file `./bin/Dracula.terminal` into the **Terminal**.
- For **iTerm2** you will have to import the [color presets](https://github.com/yusuf-kami/dotfiles/blob/master/bin/Dracula.terminal) in `./bin/Dracula.terminal` into the a new profile and apply it to the console.

These profiles can always be adjusted to your preferences once they are downloaded. The current look of the *Dracula* theme on Terminal is as follows:
![Dracula theme in Terminal](https://github.com/yusuf-kami/dotfiles/blob/master/bin/Dracula.png)

#### 1.4 `tmux`
You can also use `tmux` which is also installed within the bash setup script. This is a very useful and versatile tool for multiplexing and the script used to install it is provided [here](https://gist.github.com/simme/1297707).

To start a multiplexed session just use the command `tmux`.
Once in a `tmux` window in order to run *special commands* you need to input the *prefix* command which is **Ctrl+b**.

With this prefix provided new windows or panes can be created and navigated with the following *key binding*:
- show sessions: `s`
- create new window: `c`
- create new pane to left: `%`
- create new pane to bottom: `"`
- kill current pane: `x`
- kill current window: `&`
- navigate to next window: `n`
- navigate to previous window: `l`
- navigate to next pane: `o`
- navigate to previous pane: `;`
- (un)maximize current pane: `z`
- show description: `i`
- show pane information: `q`
- show and navigate all sessions: `w` or `s`
- change layout: `[space]`
- cycle panes: `Ctr+o`
- scroll: `[Page UP/Down]`
- search: `Ctr+s` (during scroll)
- create new window (separate): `:new`
- detach session: `d`
- enter command mode: `:`

To view all created windows externally from the `tmux` session use the command `tmux ls`. In order to kill a window the command `tmux kill-window -t {WINDOW_ID}` is used. In order to kill all windows the command `tmux kill-server` can be used.

**NOTE**: To log into an ongoing session that was detached, use the command `tmux #` (or `tmux at #`, or `tmux attach #`) within another session;

**NOTE**: To view all possible *key bindings* use the command `tmux list-keys`.

**NOTE**: In order to include the command to clear the screen using the key **Ctl+k** use the command `tmux bind -n C-k send-keys -R \; send-keys C-l \; clear-history`

**NOTE**: To make sure new windows go to a particular directory use the following binding command `tmux bind c new-window -c "~/Development"`

**NOTE**: To make sure new panes uses the same directory path as last active pane use the following binding command `tmux bind % split-window -c "#{pane_current_path}"`

**NOTE**: If your shell is using a profile script other than `~/.bash_profile` make sure you source your appropriate shell profile script in `~/.bash_profile` so all new `tmux` sessions will be able to load your shell profile.

**NOTE**: In order to kill all other session apart from the currently running one use the command `tmux kill-session -a` within another session;

**NOTE**: In `command mode` you can clear the screen by providing the `clear` command;

### 2. Git
#### 2.1. Git Profile Manager
The Git Profile Manager at **[`/git/profile.sh`](https://github.com/yusuf-kami/dotfiles/blob/master/git/profile.sh)** sets the user name and email used to interface with GitHub or Bitbucket. It also sets the Hostname used to connect to GitHub for profiles that have more than one user accounts for the same provider.
In order to be able to use the Git Profile Manager you must set up the alias in your `~/.bash_profile` with the following additions:
```~/.bash_profile
 alias gpf="echo 'Running: Git Profile Manager'; $DOTFILES_DIR/git/profile.sh "
```
The manager can then be run using the `gpf` command in the console.

#### 2.2. Git Rebaser
Included is also a Git Rebaser at **[`/git/rebaser.sh`](https://github.com/yusuf-kami/dotfiles/blob/master/git/rebaser.sh)** that is able to find all the Git directories in the system and performs a `git pull --rebase` command on all the directories.
In order to enable the Rebaser you can add the following alias in the `~/.bash_profile` file:
```~/.bash_profile
 alias grr="echo 'Running: Git Rebaser'; $DOTFILES_DIR/git/rebaser.sh "
```
The Rebaser can then be run using the `grr` command in the console.

#### 2.3 Git Hooks
There are also git hooks included in the **[`/git/`](https://github.com/yusuf-kami/dotfiles/blob/master/git/)** directory. Included are the scripts for the commit message template with the message validation, and the git push hook.
The hooks can be symlinked using the following commands:
```
 rm .git/hooks/*
 ln -fsv "$(PWD)/git/commit-msg" .git/hooks/commit-msg
 ln -fsv "$(PWD)/git/pre-push" .git/hooks/pre-push
```

#### 2.4 Git History
##### 2.4.1 Rewrite commit
Sometimes there will be an *urgent* need to rewrite the history that has already been pushed to origin.
This can be done with the following steps that was obtained from this **Stack Overflow [issue](https://stackoverflow.com/questions/3042437/change-commit-author-at-one-specific-commit)**:
1. Checkout the commit to be updated:
```
$ git checkout OLD_COMMIT_HASH
```
2. Make the changes to the commit using `git commit --amend`. With this command you can change even the *Author* of the commit with the `--author` parameter. After this command you should get a new commit hash (NEW_COMMIT_HASH) identifying the introduced changes into the branch.
3. Checkout to the main branch with `git checkout`
4. Replace the old commit with the amended commit:
```
$ git replace OLD_COMMIT_HASH NEW_COMMIT_HASH
```
5. Rewrite the history of all future commits in your trunk:
```
$ git filter-branch -- --all
```
6. Delete the old commit with `git replace -d OLD_COMMIT_HASH`

7. Push the changes to origin with `git push --force-with-lease`. If there is any issue with the `push` command then you can force the update with `git push --force` instead.

##### 2.4.2 Rewrite multiple commit history
If you would like to rewrite the history of multiple commits, change the `author`, `date` etc., you can do so by using `git rebase` functionality to pick and edit the commits as provided by the **[Git Tools](https://git-scm.com/book/en/v2/Git-Tools-Rewriting-History)**:
1. Rebase the commit range that includes those to be edited
```
$ git rebase -i HEAD~3
```
2. The above bring up an interactive editor and you must change the `pick` to `edit` on only the commits to be changed. Once the changes are picked save the edit.
```
$ pick f7f3f6d changed my name a bit
  edit 310154e updated README formatting and added blame
  pick a5f4a0d added cat-file
```
3. You will get an interactive message telling you what to do to change each picked commit. The first steps is to `amend` each commit. Doing this you can pass a new `author`, `date` etc.
```
$ git commit --amend --author="Yusuf Fadairo <yusuf.kami@gmail.com>" --date="2018-11-12 13:14:15"
```
4. Then continue the `rebase` using the `continue` command
```
$ git rebase --continue
```
5. This will continue for each and every commit you have picked. Once all rebase is complete you can push the changes to the **origin** using the force push command:
```
$ git push --force
```
**NOTE** Be careful as this will rewrite the history in the origin which might be pulled by other users.


### 3. Local Servers
To help facilitate working on many projects locally it is preferable to use [`nginx`](http://nginx.org/en/docs/) for port forwarding so there is a more defined URL to local process resolution. This is much better than just having the local domain on your `/etc/hosts` file.

#### 3.1 Using `nginx`
##### 3.1.1 Setup `nginx`
To start the server simple use the command `nginx`. If you go to `localhost:8080` you should see the default `nginx` page. The server is created using the configurations file it finds in one of the following locations `/usr/local/nginx/conf`, `/etc/nginx`, or `/usr/local/etc/nginx`.
##### 3.1.2 Port Forwarding
If you would like your apps running as specific ports to be forwarded to the default http/https ports you can configure the app as a site in the configuration file as follows:
```
# Create local port forwarding
server {
    listen 80;
    server_name local.example.com;

    location / {
        proxy_set_header   X-Forwarded-For $remote_addr;
        proxy_set_header   Host $http_host;
        proxy_pass         http://localhost:8080;
    }
}
```

For port forwarding with SSL setup you can add the following to the configuration file:
```
# Redirect from HTTP request to HTTPS
server {
   listen 80;
   return 301 https://$host$request_uri;
}

# Create local port forwarding with HTTPS
server {

    listen 443;
    server_name local.example.com;

    location / {
      proxy_set_header        Host $host;
      proxy_set_header        X-Real-IP $remote_addr;
      proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
      proxy_set_header        X-Forwarded-Proto $scheme;

      proxy_pass              http://localhost:8080;
      proxy_read_timeout      90;

      proxy_redirect          http://localhost:8080;
    }
}
```

Once this change has been made you can run the command to restart the `nginx` server:
```
$ nginx -s reload
```

Ideally it is best to have a default server setup in your `nginx` configuration so redirection are explicit. This can be done with the following lines:
```
# Default server
server {
    return 404;
}
```
##### 3.1.3 Stopping server
To start the `nginx` server use the command:
```
$ nginx -s stop
```

### 3.2 Local DevOps
To start local development there is a `docker-compose` config file at [`lib/docker-compose-ops.yml `](lib/docker-compose-ops.yml ) that contains some useful services needed for reproducing a production environment.

These services include `rabbitmq`, `mongodb` (with `mongo-express`), `redis`, `kibana` and `elasticsearch`.

To start up the services simple use the command:
```
$ docker-compose -f lib/docker-compose-ops.yml up
```

****
_Started: Jan 21, 2019_  
_Updated: Feb 17, 2023_  
