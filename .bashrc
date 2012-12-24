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
  dir=~/audio/music/ # Default Playlist Directory
  bld=false          # Rebuild Playlist
  fnd=false          # What to grep, but right now is sort as I needed to skip a pipe.
  rnd=false          # Shuffle
  hlp=false          # Show the help
  case "$1" in
    -build) [ $2 ] && dir=$2; bld=true ;; # Build the .playlist from this directory
    -help) hlp=true ;; # Show the Help
    -find) fnd=$2   ;; # What to grep
    -rand) rnd=true    # Shuffle
  esac
  case "$2" in
    -find) fnd=$3   # What to grep
  esac
  case "$3" in
    -rand) rnd=true # Shuffle
  esac
  if [ $hlp == true ]; then
    echo -e '\n---* Play *---\n'
    echo Build a new .playlist from a directory:
    echo -e '\n    Play -build '$dir'\n'
    echo Find and play everything that matches:
    echo -e '\n    Play -find match\n'
    echo Play a randomized playlist:
    echo -e '\n    Play -rand\n'
    echo Mix both:
    echo -e '\n    Play -find match -rand'
    echo -e '\n    Play -rand -find match\n'
    return
  fi
  if [ $bld == true ]; then
    find $dir \
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
  [ "$fnd" != false ] && cmd="$cmd | grep -i $fnd"
  [ "$rnd" == true  ] && cmd="$cmd | sort --random-sort"
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

