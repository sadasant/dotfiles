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
  d=~/audio/music/ # Directory
  g='sort'         # What to grep, but right now is sort as I needed to skip a pipe.
  s=false          # Shuffle
  case "$1" in
    -d) d=$2 ;;            # Change the default directory
    -g) g='grep -i '.$2 ;; # What to grep
    -s) s=true             # Shuffle
  esac
  case "$3" in
    -d) d=$4 ;;            # Change the default directory
    -g) g='grep -i '.$4 ;; # What to grep
    -s) s=true             # Shuffle
  esac
  case "$3" in
    -s) s=true             # Shuffle
  esac
  echo -e '\n---* Play *---\n'
  echo Play the contents of a directory:
  echo -e '\n    Play -d $d\n'
  echo Find a play everything that matches:
  echo -e '\n    Play -g ArtistName\n'
  echo Mix both:
  echo -e '\n    Play -d $d -g ArtistName\n'
  find $d \
     -name '*.mp3' \
  -o -name '*.wma' \
  -o -name '*.flac'\
  -o -name '*.wav' \
  -o -name '*.ogg' \
     | $g \
     | sort > /tmp/play;
  if [ "$s" == true ]; then
    mplayer -novideo -shuffle -playlist /tmp/play
  else
    mplayer -novideo -playlist /tmp/play
  fi
}

# Ping until host is reachable
NetCheck() {
  PING="/bin/ping -q -c1"
  HOST=www.google.com
  WAITTIME=3
  while [ true ]
  do
    ${PING} ${HOST}
    if [ $? -ne 0 ]; then
      echo "Link is down"
    fi
    sleep $WAITTIME
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
