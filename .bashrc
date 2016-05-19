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
pwgen() { env LC_CTYPE=C tr -dc "a-zA-Z0-9-_+-\$\?!.,-~{}[]()" < /dev/urandom | head -c $1; }

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
  host_name=$host
  # host_name=(${host//.com/})
  # host_name=(${host_name//.org/})
  user=${input[1]}
  repo=${input[2]}
  if [ -d $GOPATH/src/$host_name/$user/$repo ]; then
    echo -e "\e[31mThis repo exists.\e[0m"
    return
  fi
  cd $GOPATH/src/$host_name
  if [ ! -d ./"$user" ]; then
    mkdir "$user"
  fi
  cd "$user"
  comm="git clone https://$myuser@$host/$user/$repo.git"
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
    cd $(find -L $GOPATH/src/ -maxdepth 3 -type d | grep ${1})
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
PATH=$PATH:$HOME/code/GOPATH/src/github.com/sadasant/dotfiles/bin

# GOPATH
# export GOROOT="/usr/lib/go"
# GOROOT="$GOROOT:/usr/share/go"
export GOPATH="$HOME/code/GOPATH"
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

# No more vi
alias vi="vim"

# I git too much
alias g="git"

# If fbterm, use it
if [ -n "$FBTERM" ]; then
  export TERM=fbterm
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
