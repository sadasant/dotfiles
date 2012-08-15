# .bashrc

# Source global
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User Prompt
PS1="\`if [ \$? != 0 ]; then echo '\[\e[31;1m\]'; else echo '\[\e[37;1m\]'; fi\`
\u@\h\[\e[0m\] \w\[\e[30;1m\] \[\$(/usr/bin/who | /usr/bin/wc -l | /bin/sed 's: ::g')\e[0m\]
"

# ALIASES & FUNCTIONS

# Heroku bind
# alias heroku='~/heroku/heroku-client/heroku'
export PATH="$PATH:$HOME/.gem/ruby/1.9.1/bin"

# Screenshot
screenshot() { scrot '%Y-%m-%d_%H-%M-%S.png'  -e 'mv $f ~/img/screen' -d "${1}"; }

# Compiling and running .go files for amd64
go6 () {
  6g $1;
  file=${1%.go}
  6l -o $file $file'.6';
  ./$file $2;
}

# Compiling and running .go files for 386
go8 () {
  8g $1;
  file=${1%.go}
  8l -o $file $file'.8';
  ./$file $2;
}

