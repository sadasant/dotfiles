# .bashrc

# Source global
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User Prompt
PS1="\`if [ \$? != 0 ]; then echo '\[\e[31;1m\]'; else echo '\[\e[37;1m\]'; fi\`
\u@\h\[\e[0m\] \w\[\e[30;1m\] \$(git_current_branch) \[\e[0m\]
"

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

# Play
Play() {
  dd=~/audio/music/ # Default Directory
  d=false           # Rebuild Directory
  g=false           # What to grep, but right now is sort as I needed to skip a pipe.
  s=false           # Shuffle
  h=false           # Show the help
  case "$1" in
    -d) [ $2 ] && dd=$2; d=true ;; # Build the .playlist from this directory
    -h) h=true ;; # Show the Help
    -g) g=$2   ;; # What to grep
    -s) s=true    # Shuffle
  esac
  case "$2" in
    -g) g=$3   # What to grep
  esac
  case "$3" in
    -s) s=true # Shuffle
  esac
  if [ $h == true ]; then
    echo -e '\n---* Play *---\n'
    echo Build a new .playlist from a directory:
    echo -e '\n    Play -d $d\n'
    echo Find and play everything that matches:
    echo -e '\n    Play -g match\n'
    echo Play with shuffle:
    echo -e '\n    Play -s\n'
    echo Mix both:
    echo -e '\n    Play -g match -s'
    echo -e '\n    Play -s -g match\n'
    return
  fi
  if [ $d == true ]; then
    find $dd \
       -name '*.mp3' \
    -o -name '*.wma' \
    -o -name '*.flac'\
    -o -name '*.wav' \
    -o -name '*.ogg' \
       | sort > ~/.playlist;
    echo "Now you have a ~/.playlist :)"
    return
  fi
  cmd="cat ~/.playlist"
  [ "$g" != false ] && cmd="$cmd | grep -i $g"
  [ "$s" == true  ] && cmd="$cmd | sort --random-sort"
  eval "$cmd > /tmp/play"
  mplayer -novideo -playlist /tmp/play
}

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

# ALIASES

PATH="$PATH:$HOME/bin"

# GOPATH
GOPATH=/usr/lib/go/site:/home/sadasant/code/go:/home/sadasant/scripts/go:/home/sadasant/code/github/OpenVE/Go
PATH="$PATH:$HOME/code/go/bin"

# Android Path
PATH="$PATH:$HOME/soft/dev/android-sdk-linux/tools"
PATH="$PATH:$HOME/soft/dev/android-sdk-linux/platform-tools"

# Heroku bind
# alias heroku='~/heroku/heroku-client/heroku'
PATH="$PATH:$HOME/.gem/ruby/1.9.1/bin"

# linux-tick-processor
alias tick="/home/sadasant/code/github/joyent/node/deps/v8/tools/linux-tick-processor"

# {{{
# Node Completion - Auto-generated, do not touch.
shopt -s progcomp
for f in $(command ls ~/.node-completion); do
  f="$HOME/.node-completion/$f"
  test -f "$f" && . "$f"
done
# }}}
