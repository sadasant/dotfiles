# .bashrc

# Source global
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Source local
if [ -f ~/.bashrc_local ]; then
  . ~/.bashrc_local
fi

# User Prompt
PS1="\`if [ \$? != 0 ]; then echo '\[\e[31;1m\]'; else echo '\[\e[37;1m\]'; fi\`
\u\[\e[0m\]\[\e[30;1m\] \$(repo_or_path)\[\e[37;1m\] \$(git_current_branch) \[\e[0m\]
"

# Vi keybindings
set -o vi

# FUNCTIONS

# To show the current branch
# Used in PS1
git_current_branch() {
  hasBranch=`git branch 2>/dev/null`
  if [ $? -eq 0 ]; then
    git branch | grep '*' | cut -d' ' -f 2
  fi
}

# An alternative to repo_or_path is to use \w (in PS1),
# but this will only give you the path
repo_or_path() {
  repo=`pwd | awk '/(github.com|bitbucket.org)\/.+\/.+/ {split($0, a, /(github.com|bitbucket.org)\//); print a[2]}'`
  echo -e "${repo:=\e[30m`pwd`\e[0m}"
}

# To edit all the modified files with vim
vimodified() {
  vim $(git status --porcelain | awk '{print $2}')
}

# gitReport week for one week ago
# gitReport month for one month ago
# gitReport for one day ago
# or like gitReport three months ago
gitReport() {
  if [ "$1" = "week" ]; then
    since="one week ago"
  elif [ "$1" = "month" ]; then
    since="one month ago"
  elif [ "$1" = "" ]; then
    since="one day ago"
  else
    since=$@
  fi
  pad=$(printf '%0.1s' " "{1..60})
  padlength=20
  IFS='
'
  echo -e "\n\e[37;1mChanges from $since:\e[0m"
  for author in `git log --format='%aN' | sort -u`; do
    commits=`git shortlog -s -n --since="$since" --author="$author" | awk '{print $1;}'`
    if [ "$commits" != '' ]; then
      printf '%s' "$author"
      printf '%*.*s' 0 $((padlength - ${#author})) "$pad"
      output=`git whatchanged --since="$since" --author="$author" --oneline --shortstat | grep -E "fil(e|es) changed" | awk '{files+=$1; inserted+=$4; deleted+=$6} END {print "files changed:", files, "\tlines inserted:", inserted, "\tlines deleted:", deleted }'`
      echo -e "\tcommits: $commits\t$output"
    fi
  done
}

# Password Generator
pwgen() { < /dev/urandom tr -dc A-Za-z0-9_+-?\?! | head -c$1; }

# Passphrase Generator
phrase() { shuf -n$1 /usr/share/dict/words | tr '\n' ' '; }

# Ping until host is reachable
NetCheck() {
  host=www.google.com
  waittime=3
  while [ true ]
  do
    ping ${host}
    if [ $? -ne 0 ]; then
      echo "Link is down"
    fi
    sleep $waittime
  done
}

# Quick search terms recursivelly
f() {
    grep -rinI $1 . ${*:2}
}

# Easy git clone
# Usage:
#
#     clone user/repo
#
clone() {
  provider=""
  myuser="sadasant"
  input=(${1//\// })
  if [ ${#input[@]} -lt 2 ]; then
    echo -e "\e[31mclone user/repo\e[0m"
    return
  fi
  user=${input[0]}
  repo=${input[1]}
  hosts=("github.com" "bitbucket.org")
  for host in "${hosts[@]}"; do
    if [ -d $HOME/code/$host/$user/$repo ]; then
      echo -e "\e[31mThis repo exists.\e[0m"
      return
    fi
    fullPath="$host/$user/$repo"
    repoExists=`git ls-remote https://"$fullPath" 2>/dev/null`
    if [ $? -eq 0 ]; then
      echo -e "\e[32;1mFound:\e[0m \e[32m$fullPath\e[0m"
      provider=$host
      break
    fi
  done
  if [[ -z $provider ]]; then
    echo -e "\e[31mRepository not found.\e[0m"
    return
  fi
  cd $HOME/code/$provider
  if [ ! -d ./"$user" ]; then
    mkdir "$user"
  fi
  cd "$user"
  comm="git clone https://$myuser@$provider/$user/$repo.git"
  history -s $comm
  eval $comm
  if [ $? -eq 0 ]; then
    cd $repo
  fi
}

# Reorder tmux windows
# http://stackoverflow.com/a/8835493
function sortmux() {
    # re-number tmux sessions
    for session in $(tmux ls | awk -F: '{print $1}') ;do
        inum=0
        active_index=$(tmux lsw -t ${session} | grep -n "active" | head -c 1)
        old_active=$(tmux lsw -t ${session} | awk "NR==${active_index}" | head -c 1)
        for window in $(tmux lsw -t ${session} | awk -F: '/^[0-9*]/ {print $1}') ;do
            if [ ${window} -gt ${inum} ] ;then
                echo "${session}:${window} -> ${session}:${inum}"
                tmux movew -d -s ${session}:${window} -t ${session}:${inum}
            fi
            inum=$((${inum}+1))
        done
        active=$(tmux lsw -t ${session} | awk "NR==${active_index}" | head -c 1)
        if [ $old_active -ne $active ]; then
            tmux select-window -t ${session}:${active}
            echo "Active ${old_active} is now ${active}"
        fi
    done
}

# Quick CD
function goto() {
    cd $(find -L $HOME/code/ -maxdepth 3 -type d | grep ${1})
}

# System Usage Percentages
function system_status() {
  free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
  df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
  top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}' 
}

# HISTORY

# Suppresses duplicate commands, the simple invocation of 'ls' without any
# arguments, and the shell built-ins bg, fg, and exit.
HISTIGNORE="&:ls:[bf]g:exit"

HISTFILESIZE=1000
HISTSIZE=$HISTFILESIZE

# PATH
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$HOME/code/github/sadasant/dotfiles/bin

alias tmux='tmux -2'

alias nvim="$HOME/Downloads/nvim.appimage"
alias vim="nvim"

# No more vi
alias vi="vim"

# I git too much
alias g="git"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/home/sadasant/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# fzf, but limited to git ls-files
function gitfzf() {
  echo `(git ls-files --cached --others --exclude-standard || find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null | fzf --query="$1"`
}

# Quick git tree find and edit on vim.
# Called "t" because of github.
# How it works:
# - If vim is a stopped process,
#   - Run gitfzf with the given input parameter
#   - If gitfzf returned nothing, stop
#   - If it returned a valid file,
#     - Save the full path on ~/.for-vim, this is important because sometimes $:p:h is not the current directory
#     - Then, set to load it on vim using a perl ioctl hack
#     - Wake up vim (actually just the last stopped job, but that's fine for me)
#   - Else, show a message saying that the file doesn't exist
# - If vim is not a stopped process, just open the output on vim.
# How to use it:
#   t [query] # It will start with the query as the input of the search
#   t         # It will start with a blank search
function t() {
  hasStoppedVim=`jobs | grep vim`
  if [ $? -eq 0 ]; then
    # Inspired by https://unix.stackexchange.com/questions/246419/open-file-with-started-vim-from-outside-in-terminal
    file=`gitfzf $1`
    if [[ -z $file ]]; then
      return
    fi
    if [ -f $file ]; then
      full=`readlink -f $file`
      echo $full > ~/.for-vim
      perl -le 'require "sys/ioctl.ph"; ioctl(STDIN, &TIOCSTI, $_)
        for split "", "\e:tabf `cat ~/.for-vim`\r"'
      fg
    else
      echo "Can't open file $file"
      echo "It is probably deleted."
    fi
  else
    vim `gitfzf $1`
  fi
}

# csd: "changes' dierctory", as in the directory of the changes.
# Changes the directory to the common parent to all the changes in current branch.
# Specially useful to switch to the folder relevant to the changes that a specific branch or Pull Request makes in a large project.
# By default acts based on the current changes to the current branch, but another target can be spcified by passing a single argument.
# Example: csd master # changes to the common parent relative to the master branch.
# Source of the regexp: https://stackoverflow.com/a/17475354
function csd() {
  common_prefix=$(git diff $1 --name-only | sed -e 'N;s/^\(.*\).*\n\1.*$/\1\n\1/;D') 
  common_parent=${common_prefix%/*}
  cd $(git rev-parse --show-toplevel)/$common_parent
}
