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
\u@\h\[\e[0m\] \w\[\e[30;1m\] \$(git_current_branch) \[\e[0m\]
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

# Easy git update
# Usage:
#
#     Gupdate
#     Gupdate origin
#     Gupdate origin my-branch
#
Gupdate() {
  remote="origin"
  branch="master"
  if [ ! -z $git_current_branch ]; then
    branch=$git_current_branch
  fi
  if [ ! -z $1 ]; then
    remote=$1
  fi
  if [ ! -z $2 ]; then
    branch=$2
  fi
  git fetch $remote
  git rebase -p $remote/$branch
}

# Easy git clone
# Usage:
#
#     Gclone provider/user/repo
#
Gclone() {
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
  git clone https://"$myuser"@"$host"/"$user"/"$repo".git
}

# Quick Access to Repos
# Usage:
#
#     goto myfilenam
#
goto() {
  i=0
  if [ -z $1 ]; then
    return
  fi
  for dir in $(find ~/code -type d -name "*$1*" ); do
    echo -e "\e[37;1m$i\e[0m \e[34;1m$dir\e[0m"
    found[$i]="$dir"
    ((i++))
  done
  read -p "cd number: " n
  if [ $n ] && [ $n -lt $i ]; then
    cd ${found[$n]}
    return
  fi
  echo -e "\e[31;1mWront Input\e[0m"
}

# Browse a directory and pick something
# Usage:
#
#     list
#     0 ..
#     1 Documents
#     2 Images
#     3 Programming
#     [command]? [0..N]: ? Doc
#     $ list ? Doc
#     0 Documents
#     [command]? [0..N]: 0 ? .md
#     $ list Documents ? .md
#     0 README.md
#     [command]? [0..N]: vim 0
#     $ vim README.md
#
list() {
  _IFS=$IFS
  IFS=$'\n'
  _ls="ls -a1 ."
  if [ ! -z $1 ]; then
    if [ $1 == "?" ]; then
      _ls+=" | grep $2"
    else
      cd $1
      if [ ! -z $2 ] && [ $2 == "?" ]; then
        _ls+=" | grep $3"
      fi
    fi
  fi
  i=0
  declare -A found
  for item in $(eval $_ls); do
    if [ $item == "." ]; then
      continue
    fi
    _item="\e[34m$item\e[0m"
    if [ -d $item ]; then
      _item="\e[34;1m$item\e[0m"
    fi
    echo -e "\e[37;1m$i\e[0m $_item"
    found[$i]=$item
    ((i++))
  done
  IFS=$_IFS
  read -p "[command]? [0..N]: " input
  comm=""
  countp=0
  for p in $input; do
    if [[ "$p" =~ ^[0-9]+$ ]]; then
      if [ $countp == 0 ]; then
        comm+="list "
      fi
      comm+="'${found[$p]}' "
    else
      if [ $countp == 0 ] && [ $p == "?" ]; then
        comm+="list "
      fi
      comm+="$p "
    fi
    ((countp++))
  done
  if [ $countp == 1 ] && [ "$comm" == "$input " ]; then
    comm+="."
  fi
  echo -e "\e[32;1m$ \e[0m\e[32m$comm\e[0m"
  eval $comm
}

# ALIASES

PATH="$PATH:$HOME/bin"
PATH="$PATH:$HOME/code/github/sadasant/dotfiles/bin"

# GOPATH
GOPATH=/usr/lib/go/site:/home/sadasant/code/go:/home/sadasant/code/github/sadasant/scripts/go:/home/sadasant/code/github/OpenVE/Go
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
