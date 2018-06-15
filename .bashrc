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
\u\[\e[0m\] \w\[\e[30;1m\] \$(git_current_branch) \[\e[0m\]
"

# Vi keybindings
set -o vi

# FUNCTIONS

# To show the current branch
# Used in PS1
git_current_branch() {
  if [ -d .git ]; then
    git branch | grep '*' | cut -d' ' -f 2
  fi
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

# Screenshot
screenshot() { scrot '%Y-%m-%d_%H-%M-%S.png'  -e 'mv $f ~/img/screen' -d "${1}"; }

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
search() {
    grep -rinI $1 . ${*:2}
}

# From where am I connected?
whereami() { echo `whois $(curl -s ifconfig.me/ip) | grep -iE ^country: | awk '{print $2}' | uniq`; }

# Benchmark
benchmark() {
  TIMEFORMAT="%R"
  count=$1
  shift
  i=1
  time=$({ time while [[ $i -le $count ]]; do "$@" > /dev/null; ((i = i + 1)); done } 2>&1)
  total=$(awk -v time=$time -v count=$count 'BEGIN { print time/count }')
  echo $time/$count = $total
}

# Easy git update
# Usage:
#
#     GUPDATE
#     GUPDATE origin
#     GUPDATE origin my-branch
#
GUPDATE() {
  remote="origin"
  branch=$(git_current_branch)
  if [ ! -z $1 ]; then
    remote=$1
  fi
  if [ ! -z $2 ]; then
    branch=$2
  fi
  c1="git fetch $remote"
  c2="git rebase -p $remote/$branch"
  printf "\e[32m%s\n%s\n\e[0m" "$c1" "$c2"
  history -s $c1
  history -s $c2
  eval $c1
  eval $c2
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
    if [ -d /home/sadasant/code/$host/$user/$repo ]; then
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
  cd /home/sadasant/code/$provider
  if [ ! -d ./"$user" ]; then
    mkdir "$user"
  fi
  cd "$user"
  comm="git clone https://$myuser@$provider/$user/$repo.git"
  history -s $comm
  eval $comm
}

# pushd quickly
# http://unix.stackexchange.com/questions/31161/quick-directory-navigation-in-the-terminal
function pd() {
  if [[ $# -ge 1 ]]; then
    choice="$1"
  else
    dirs -v
    echo -n "? "
    read choice
  fi
  if [[ -n $choice ]]; then
    declare -i cnum="$choice"
    if [[ $cnum != $choice ]]; then #choice is not numeric
      choice=$(dirs -v | grep $choice | tail -1 | awk '{print $1}')
      cnum="$choice"
      if [[ -z $choice || $cnum != $choice ]];
      then
        echo "$choice not found"
        return
      fi
    fi
    choice="+$choice"
  fi
  pushd $choice
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
    cd $(find -L /home/sadasant/code/ -maxdepth 3 -type d | grep ${1})
}

# Quick vim find. Called "t" because of github
function t() {
    files=$(find -iname "*${1}*" -not -path "*/node_modules/*" -not -path "*/.git/*" | head -5)
    count=0
    for file in $files; do
        echo "$count: $file"
        count=$((${count}+1))
    done
    echo -n "? "
    read choice
    arrayFiles=($files)
    vim ${arrayFiles[$choice]}
}

# System Usage Percentages
function system_status() {
  free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
  df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
  top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}' 
}

# Cleaning NPM
function npmclean() {
  rm package-lock.json
  rm -fr node_modules
  npm prune && npm i
}

# Files with the most common lines in current directory
function mostCommon() {
  files=$(ls -p | grep -v /) # ls for files only
  file1r=""
  file2r=""
  result=""
  longest=0
  for file1 in $files; do
    for file2 in $files; do
      if [ "$file1" == "$file2" ];
      then
        continue
      fi
      comms=$(grep -F -x -f $file1 $file2)
      len=${#comms}
      if (( len > longest ))
      then
        file1r=$file1
        file2r=$file2
        longest=$len
        result=$comms
      fi
    done
  done
  echo $file1r $file2r $longest
  echo -e "\n$result"
}

# HISTORY

# Suppresses duplicate commands, the simple invocation of 'ls' without any
# arguments, and the shell built-ins bg, fg, and exit.
HISTIGNORE="&:ls:[bf]g:exit"

HISTFILESIZE=1000
HISTSIZE=$HISTFILESIZE

# PATH
PATH=$PATH:$HOME/bin
PATH=$PATH:/usr/local/go/bin
PATH=$PATH:$HOME/code/github/sadasant/dotfiles/bin

# GOPATH
# export GOROOT="/usr/lib/go"
# GOROOT="$GOROOT:/usr/share/go"
export GOPATH="$HOME/code/go"
PATH="$PATH:$HOME/code/code.google.com/go/bin"
PATH="$PATH:$GOPATH/bin"

# Android Path
PATH="$PATH:$HOME/soft/dev/android-sdk-linux/tools"
PATH="$PATH:$HOME/soft/dev/android-sdk-linux/platform-tools"

# Heroku bind
PATH="/usr/local/heroku/bin:$PATH"
PATH="$PATH:$HOME/.gem/ruby/2.1.0/bin"

# linux-tick-processor
alias tick="$HOME/code/github/joyent/node/deps/v8/tools/linux-tick-processor"

if [ "$TERM" == "linux" ]; then
    alias tmux='tmux -f ~/.tmux.vb.conf'
else
    alias tmux='TERM=screen-256color tmux'
fi

if [ -f /.dockerenv ]; then
    export TERM='xterm-256color'
fi

# Neovim if available
if [ -x "$(command -v nvim)" ]; then
  alias vim="nvim"
fi

# No more vi
alias vi="vim"
# I viw too much
alias v="vim"

# I git too much
alias g="git"

# If fbterm, use it
if [ -n "$FBTERM" ]; then
  export TERM=fbterm
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

alias babel="./node_modules/.bin/babel-node"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
