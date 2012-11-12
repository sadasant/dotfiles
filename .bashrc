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

# cp Progress bar

# ALIASES

# GOPATH
GOPATH=/usr/lib/go/site:/home/sadasant/code/go:/home/sadasant/scripts/go:/home/sadasant/code/github/OpenVE/Go
PATH="$PATH:/home/sadasant/code/go/bin"

# Heroku bind
# alias heroku='~/heroku/heroku-client/heroku'
export PATH="$PATH:$HOME/.gem/ruby/1.9.1/bin"

# linux-tick-processor
alias tick="/home/sadasant/code/github/joyent/node/deps/v8/tools/linux-tick-processor"
