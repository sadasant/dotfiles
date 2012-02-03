# .bashrc

# Source global
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User Prompt
PS1="\n\[\e[37;1m\]\`if [ \$? = 0 ]; then echo \
[\[\e[0m\]\[\$(/usr/bin/who | /usr/bin/wc -l | /bin/sed 's: ::g')\e[1m\]]\
; else echo \[\e[30m\][!];fi\`[\u][\h]\[\e[30;1m\][\[\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g'), \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b][\w]\n\[\e[0m\]\[\e[0m\]"

# ALIASES & FUNCTIONS

# Heroku bind
alias heroku='~/heroku/heroku-client/heroku'

# Screenshot
screenshot() { scrot '%Y-%m-%d_%H-%M-%S.png'  -e 'mv $f ~/img/screen' -d "${1}"; }

# Compiling and running .go files
go () {
  6g $1;
  file=${1%.go}
  6l -o $file $file'.6';
  ./$file $2;
}
