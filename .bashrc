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

# Easy git clone
# How to use:
#
#    gitclone -gh user repo
#
gitclone() {
  provider=""
  myuser="sadasant"
  case "$1" in
    -gh) provider="github"    ;;
    -bb) provider="bitbucket" ;;
  esac
  if [ provider == "" ]; then
    echo Please specify the provider
    return
  fi
  cd ~/code/$provider
  if [ ! -d ./"$2" ]; then
    mkdir "$2"
  fi
  case "${provider}" in
    github)    provider+=".com" ;;
    bitbucket) provider+=".org" ;;
  esac
  cd "$2"
  git clone https://"${myuser}"@"${provider}"/"$2"/"$3".git

}

# Quick Access to Repos
# How to use:
#
#    goto myfilenam
#
goto() {
  i=0
  if [ $1 == "" ]; then
    return
  fi
  for dir in $(find ~/code -type d -name "*$1*" ); do
    echo -e "\e[37;1m$i\e[0m: $dir"
    found[$i]="$dir"
    ((i++))
  done
  read -p "Change dir to number: " n
  if [ $n ] && [ $n -lt $i ]; then
    cd ${found[$n]}
    return
  fi
  echo -e "\e[31;1mWront Input\e[0m"
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
