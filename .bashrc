# .bashrc

# Source global
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

git_current_branch() {
  git branch | grep '*' | cut -d' ' -f 2
}

# User Prompt
PS1="\`if [ \$? != 0 ]; then echo '\[\e[31;1m\]'; else echo '\[\e[37;1m\]'; fi\`
\u@\h\[\e[0m\] \w\[\e[30;1m\] \$(git_current_branch) \[\e[0m\]
"

# ALIASES & FUNCTIONS

# Heroku bind
# alias heroku='~/heroku/heroku-client/heroku'
export PATH="$PATH:$HOME/.gem/ruby/1.9.1/bin"

# Screenshot
screenshot() { scrot '%Y-%m-%d_%H-%M-%S.png'  -e 'mv $f ~/img/screen' -d "${1}"; }

# GOPATH
GOPATH=/usr/lib/go/site:/home/sadasant/code/go:/home/sadasant/scripts/go:/home/sadasant/code/github/OpenVE/Go

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
