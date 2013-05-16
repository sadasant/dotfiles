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

# Screenshot
screenshot() { scrot '%Y-%m-%d_%H-%M-%S.png'  -e 'mv $f ~/img/screen' -d "${1}"; }

# Password Generator
pwgen() { < /dev/urandom tr -dc A-Za-z0-9_+-?\?! | head -c$1; }

# Ping until host is reachable
NetCheck() {
  ping="/bin/ping -q -c1"
  host=www.google.com
  waittime=3
  while [ true ]
  do
    ${ping} ${host}
    if [ $? -ne 0 ]; then
      echo "Link is down"
    fi
    sleep $waittime
  done
}

# cp with progress bar
cp_p() {
  if [ -d $1 ]; then
    while read line; do
      to=${line/$1/$2}
      to=${to//\/\//\/} # Replace all // matches.
      if [ -d "$line" ]; then
        echo "Directory: $to"
        mkdir -p "$to"
      else
        echo "File: $to"
        pv "$line" > "$to"
      fi
    done < <(find "$1"/*)
  fi
}

# Quick Access to Repos
# Usage:
#
#     CODE myfilename
#
CODE() {
  i=0
  if [ -z $1 ]; then
    return
  fi
  sadasant_list_found=()
  for dir in $(find ~/code -type d -not -iwholename '*.git*' -name "*$1*" -prune); do
    echo -e "\e[37;1m$i\e[0m \e[34;1m$dir\e[0m"
    sadasant_list_found[$i]="$dir"
    ((i++))
  done
  read -p "cd number: " n
  if [ $n ] && [ $n -lt $i ]; then
    comm="cd ${sadasant_list_found[$n]}"
    echo -e "\e[0m\e[32m$comm\e[0m"
    history -s $comm
    eval $comm
    return
  fi
  echo -e "\e[31;1mWrong Input\e[0m"
}

# Browse a directory and pick something
# Usage:
#
#     LIST
#     0 ..
#     1 Documents
#     2 Images
#     3 Programming
#     LIST ? Doc
#     0 Documents
#     LIST 0 ? .md
#     0 README.md
#
declare -A sadasant_list_found
sadasant_list_dir=""
LIST() {
  _IFS=$IFS
  IFS=$'\n'
  _ls="ls -a1 "
  if [ ! -z $1 ]; then
    if [ $1 == "?" ]; then
      _ls+="$sadasant_list_dir | grep $2"
    elif [[ "$1" =~ ^[0-9]+$ ]]; then
      sadasant_list_dir+="${sadasant_list_found[$1]}/"
      _ls+=$sadasant_list_dir
    else
      sadasant_list_dir="$1"
      _ls+=$sadasant_list_dir
    fi
    if [ ! -z $2 ] && [ $2 == "?" ]; then
      _ls+=" | grep $3"
    fi
  else
    sadasant_list_dir="$(pwd)/"
  fi
  i=0
  sadasant_list_found=()
  for item in $(eval $_ls); do
    if [ $item == "." ]; then
      continue
    fi
    _item="\e[34m$item\e[0m"
    if [ -d $item ]; then
      _item="\e[34;1m$item\e[0m"
    fi
    echo -e "\e[37;1m$i\e[0m $_item"
    sadasant_list_found[$i]=$item
    ((i++))
  done
  IFS=$_IFS
}

# Do whatever you want with the saved list
# Usage:
#
#     LIST
#     0 ..
#     1 README.md
#     DO vim 0
#     vim README.md
#
DO() {
  if [ ${#sadasant_list_found[*]} -eq 0 ]; then
    echo "First:"
    echo -e "\e[32ml\e[0m"
    return
  fi
  comm=""
  countp=0
  for p in $*; do
    if [[ "$p" =~ ^[0-9]+$ ]]; then
      if [ $countp == 0 ]; then
        comm+="LIST "
      fi
      comm+="'$sadasant_list_dir${sadasant_list_found[$p]}' "
    else
      if [ $countp == 0 ] && [ $p == "?" ]; then
        comm+="LIST "
      fi
      comm+="$p "
    fi
    ((countp++))
  done
  if [ $countp == 1 ]; then
    comm+=$sadasant_list_dir
  fi
  echo -e "\e[0m\e[32m$comm\e[0m"
  history -s $comm
  eval $comm
}

# Quick Access to git branches
# Usage:
#
#     GLIST
#
GLIST() {
  i=0
  declare -A found
  branches="git branch -a"
  if [ ! -z $1 ]; then
    branches+=" | grep $1"
  fi
  _IFS=$IFS
  IFS=$'\n'
  sadasant_list_found=()
  for branch in $(eval $branches); do
    if [[ "$branch" =~ "->" ]]; then
      continue
    elif [[ "$branch" =~ "remotes/" ]]; then
      echo -e "\e[37;1m$i\e[0m \e[34m$branch\e[0m"
      branch=${branch//[ ]/}
      branch=$(echo $branch | cut -d "/" -f2-)
      sadasant_list_found[$i]="$branch"
    else
      echo -e "\e[37;1m$i\e[0m \e[34;1m$branch\e[0m"
      branch=${branch//[ \*]/}
      sadasant_list_found[$i]="$branch"
    fi
    ((i++))
  done
  IFS=$_IFS
  echo "DO git command [0..N]"
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
#     GCLONE provider/user/repo
#
GCLONE() {
  provider=""
  myuser="sadasant"
  input=(${1//\// })
  if [ ${#input[@]} -lt 3 ]; then
    echo -e "\e[31mGclone host/user/repo\e[0m"
    return
  fi
  host=${input[0]}
  host_name=(${host//.com/})
  host_name=(${host_name//.org/})
  user=${input[1]}
  repo=${input[2]}
  if [ -d ~/code/$host_name/$user/$repo ]; then
    echo -e "\e[31mThis repo exists.\e[0m"
    return
  fi
  cd ~/code/$host_name
  if [ ! -d ./"$user" ]; then
    mkdir "$user"
  fi
  cd "$user"
  comm="git clone https://$myuser@$host/$user/$repo.git"
  history -s $comm
  eval $comm
}

# HISTORY
# HISTIGNORE
# Suppresses duplicate commands, the simple invocation of 'ls' without any
# arguments, and the shell built-ins bg, fg, and exit.
HISTIGNORE="&:ls:[bf]g:exit"
# HISTSIZE
HISTFILESIZE=1000
HISTSIZE=$HISTFILESIZE

# PATH
PATH="$PATH:$HOME/bin"
PATH="$PATH:$HOME/code/github/sadasant/dotfiles/bin"

# GOPATH
GOPATH=/home/sadasant/code/go
PATH="$PATH:$HOME/code/code.google.com/go/bin"
PATH="$PATH:$HOME/code/go/bin"

# Android Path
PATH="$PATH:$HOME/soft/dev/android-sdk-linux/tools"
PATH="$PATH:$HOME/soft/dev/android-sdk-linux/platform-tools"

# Heroku bind
# alias heroku='~/heroku/heroku-client/heroku'
PATH="$PATH:$HOME/.gem/ruby/1.9.1/bin"

# linux-tick-processor
alias tick="/home/sadasant/code/github/joyent/node/deps/v8/tools/linux-tick-processor"

# 256 colors in Tmux
alias tmux='TERM=screen-256color tmux'
# The line above breaks colors in the tty tmux
