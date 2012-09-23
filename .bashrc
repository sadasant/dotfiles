# .bashrc

# Source global
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User Prompt
PS1="\`if [ \$? != 0 ]; then echo '\[\e[31;1m\]'; else echo '\[\e[37;1m\]'; fi\`
\u@\h\[\e[0m\] \w\[\e[30;1m\]\[\e[0m\]
"

# ALIASES & FUNCTIONS

# Heroku bind
# alias heroku='~/heroku/heroku-client/heroku'
export PATH="$PATH:$HOME/.gem/ruby/1.9.1/bin"

# Screenshot
screenshot() { scrot '%Y-%m-%d_%H-%M-%S.png'  -e 'mv $f ~/img/screen' -d "${1}"; }

