# Source global
if [ -f /etc/bashrc ]; then . /etc/bashrc; fi

# Source local
if [ -f ~/.bashrc_local ]; then . ~/.bashrc_local; fi

set -o vi # Vi keybindings

# Suppresses duplicate commands, the simple invocation of 'ls' without any
# arguments, and the shell built-ins bg, fg, and exit.
HISTIGNORE="&:ls:[bf]g:exit"
HISTFILESIZE=1000
HISTSIZE=$HISTFILESIZE

# PATH
PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/.local/bin
PATH=$PATH:$HOME/code/github/sadasant/dotfiles/bin
PATH=$PATH:$HOME/code/github.com/sadasant/dotfiles/bin

# NVM PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# PYENV PATH
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi
# export PATH="$HOME/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# FZF PATH
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# FZF Theme
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#6b6b6b,bg:#121212,hl:#9c4141 --color=fg+:#ffffff,bg+:#262626,hl+:#ff0000 --color=info:#d17575,prompt:#d7005f,pointer:#ffffff --color=marker:#ff0000,spinner:#ffffff,header:#d17575'

# ALIASES
# if ! [ -x "$(command -v nvim)" ]; then
#   alias nvim="$HOME/Downloads/nvim.appimage"
# fi
alias tmux='tmux -2'
alias vim="nvim"
alias g="git" # I git too much
alias wip="git wip" # I git too much
alias r="rush" # I rush too much
alias rx="rushx" # I rushx too much
alias monitor="watch tail -n 15"

# NOW, FUNCTIONS

# To show the current branch
# Used in PS1
git_current_branch() {
  hasBranch=`git branch 2>/dev/null`
  if [ $? -eq 0 ]; then
    git branch | grep '*' | cut -d' ' -f 2
  fi
}

# An alternative to repo_or_path is to use \w (in PS1),
# but this will only give you the path
repo_or_path() {
  repo=`pwd | awk '/(github.com|bitbucket.org)\/.+\/.+/ {split($0, a, /(github.com|bitbucket.org)\//); print a[2]}'`
  repo="${repo:=`pwd`}"
  # TMUX rename window
  # tmux rename-window $repo
  echo $repo
}

# To edit all the modified files with vim
vimodified() {
  toplevel=`git rev-parse --show-toplevel`
  paths=$(git status --porcelain | awk -v toplevel=$toplevel '{print toplevel"/"$2}')
  echo -e "Opening:\n$paths"
  # Open in tabs
  vim -p $paths
}

# To edit all the modified files since a commit
vimdiff() {
  paths=$(git diff $1 --name-only)
  echo -e "Opening:\n$paths"
  # Open in tabs
  vim -p $paths
}

# gitReport week for one week ago
# gitReport month for one month ago
# gitReport for one day ago
# or like gitReport three months ago
gitReport() {
  if [ "$1" = "week" ]; then
    since="one week ago"
  elif [ "$1" = "month" ]; then
    since="one month ago"
  elif [ "$1" = "" ]; then
    since="one day ago"
  else
    since=$@
  fi
  pad=$(printf '%0.1s' " "{1..60})
  padlength=20
  IFS='
'
  echo -e "\n\e[37;1mChanges from $since:\e[0m"
  for author in `git log --format='%aN' | sort -u`; do
    commits=`git shortlog -s -n --since="$since" --author="$author" | awk '{print $1;}'`
    if [ "$commits" != '' ]; then
      printf '%s' "$author"
      printf '%*.*s' 0 $((padlength - ${#author})) "$pad"
      output=`git whatchanged --since="$since" --author="$author" --oneline --shortstat | grep -E "fil(e|es) changed" | awk '{files+=$1; inserted+=$4; deleted+=$6} END {print "files changed:", files, "\tlines inserted:", inserted, "\tlines deleted:", deleted }'`
      echo -e "\tcommits: $commits\t$output"
    fi
  done
}

# Password Generator
pwgen() { < /dev/urandom tr -dc A-Za-z0-9_+-?\?! | head -c$1; }

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

# Easy git clone
# Usage:
#
#     clone user/repo
#
clone() {
  provider=""
  myuser="sadasant"
  input=(${1//\// })
  if [ ${#input[@]} -lt 2 ]; then
    echo -e "\e[31mclone user/repo\e[0m"
    return
  fi
  user=${input[0]}
  repo=${input[1]}
  hosts=("github.com" "bitbucket.org")
  for host in "${hosts[@]}"; do
    if [ -d $HOME/code/$host/$user/$repo ]; then
      echo -e "\e[31mThis repo exists.\e[0m"
      return
    fi
    fullPath="$host/$user/$repo"
    repoExists=`git ls-remote https://"$fullPath" 2>/dev/null`
    if [ $? -eq 0 ]; then
      echo -e "\e[32;1mFound:\e[0m \e[32m$fullPath\e[0m"
      provider=$host
      break
    fi
  done
  if [[ -z $provider ]]; then
    echo -e "\e[31mRepository not found.\e[0m"
    return
  fi
  cd $HOME/code/$provider
  if [ ! -d ./"$user" ]; then
    mkdir "$user"
  fi
  cd "$user"
  # comm="git clone https://$myuser@$provider/$user/$repo.git"
  comm="git clone git@$provider:$user/$repo.git"
  history -s $comm
  eval $comm
  if [ $? -eq 0 ]; then
    cd $repo
  fi
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
# goto changes directory to the first matching a given string.
# It goes only three levels deep. It also ignores files within node_modules and .git
function goto() {
    result=$(find -L . -maxdepth 3 -type d -not -path './node_modules*' -not -path '*/node_modules*' -a -not -path '*.git*' | grep ${1})
    echo "Found: $result"
    if [[ -z $result ]]; then return; fi
    cd $result
}
# code does cd into $HOME/code and then does goto with the arguments passed
function code() {
    cd $HOME/code
    if [[ -z $1 ]]; then return; fi
    goto $1
}

# System Usage Percentages
function system_status() {
  free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
  df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
  top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}' 
}

# Quick search terms recursivelly
# Ignores files in node_modules and .git
# Removes duplicated results
match() {
  grep -rinI -m1 $1 . ${*:2} --exclude-dir=node_modules --exclude-dir=.git | sort -u
}

# fzf, but limited to git ls-files
function gitfzf() {
  echo `(git ls-files --cached --others --exclude-standard || find . -path "*/\.*" -prune -o -type f -print -o -type l -print | sed s/^..//) 2> /dev/null | fzf --query="$1"`
}

# Quick git tree find and edit on vim.
# Called "t" because of github.
# How it works:
# - If vim is a stopped process,
#   - Run gitfzf with the given input parameter
#   - If gitfzf returned nothing, stop
#   - If it returned a valid file,
#     - Save the full path on ~/.for-vim, this is important because sometimes $:p:h is not the current directory
#     - Then, set to load it on vim using a perl ioctl hack
#     - Wake up vim (actually just the last stopped job, but that's fine for me)
#   - Else, show a message saying that the file doesn't exist
# - If vim is not a stopped process, just open the output on vim.
# How to use it:
#   t [query] # It will start with the query as the input of the search
#   t         # It will start with a blank search
function t() {
  hasStoppedVim=`jobs | grep vim`
  if [ $? -eq 0 ]; then
    # Inspired by https://unix.stackexchange.com/questions/246419/open-file-with-started-vim-from-outside-in-terminal
    file=`gitfzf $1`
    if [[ -z $file ]]; then
      return
    fi
    if [ -f $file ]; then
      full=`readlink -f $file`
      echo $full > ~/.for-vim
      perl -le 'require "sys/ioctl.ph"; ioctl(STDIN, &TIOCSTI, $_)
        for split "", "\e:tabf `cat ~/.for-vim`\r"'
      fg
    else
      echo "Can't open file $file"
      echo "It is probably deleted."
    fi
  else
    vim `gitfzf $1`
  fi
}

# csd: "changes' dierctory", as in the directory of the changes.
# Changes the directory to the common parent to all the changes in current branch.
# Specially useful to switch to the folder relevant to the changes that a specific branch or Pull Request makes in a large project.
# By default acts based on the current changes to the current branch, but another target can be spcified by passing a single argument.
# Example: csd master # changes to the common parent relative to the master branch.
# Source of the regexp: https://stackoverflow.com/a/17475354
function csd() {
  common_prefix=$(git diff $1 --name-only | sed -e 'N;s/^\(.*\).*\n\1.*$/\1\n\1/;D') 
  common_parent=${common_prefix%/*}
  cd $(git rev-parse --show-toplevel)/$common_parent
}

# Tmux tab name
case "$TERM" in
linux|xterm*|rxvt*)
  export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'
  ;;
screen*)
  export PROMPT_COMMAND='echo -ne "\033k${PWD##*/}\033\\"'
  ;;
*)
  ;;
esac

# Github ssh key
eval `ssh-agent -s`
ssh-add ~/.ssh/github

# Lessons from the VSCode team
function vs-jupyterStart() {
  jupyter notebook --no-browser --NotebookApp.allow_origin=* --NotebookApp.disable_check_xsrf=true
}
function vs-compile() {
  echo "Important: use 'npm run compiled' instead"
  npm run clean
  tsc -p ./
  npm run compile-web
  ## npm run compile-webviews-watch
  ./node_modules/.bin/webpack --config ./build/webpack/webpack.datascience-ui.config.js
}
function vs-update() {
  read -p "Do you want to update the VSCode typescript files? [y/N] " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    git clean -fxd
    npm ci
  fi
}
# From: https://code.visualstudio.com/api/extension-guides/web-extensions#test-your-web-extension-in-on-vscode.dev
function vs-web-serve() {
  npx serve --cors -l 5555 # Port 5000 is busy on my Mac
}
# From: https://code.visualstudio.com/api/extension-guides/web-extensions#test-your-web-extension-in-on-vscode.dev
function vs-web-tunnel() {
  npx localtunnel -p 5555 # Port 5000 is busy on my Mac
}
function vs-unit-test() {
  npm run clean
  tsc -p ./
  if [ $# -eq 0 ]
  then npm run test:unittests
  else npm run test:unittests -- --grep="$@"
  fi
}
function vs-integration-test() {
  read -p "Did you run vs-compile? [y/N] " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    command="
    npm run pretestNativeNotebooksInVSCode && 
    CI_PYTHON_PATH=/opt/anaconda3/bin/python \
    VSC_FORCE_REAL_JUPYTER=1 \
    VSC_JUPYTER_FORCE_LOGGING=1 \
    VSC_PYTHON_FORCE_LOGGING=1 \
    VSC_JUPYTER_REMOTE_NATIVE_TEST=false \
    VSC_JUPYTER_NON_RAW_NATIVE_TEST=true \
    VSC_JUPYTER_CI_RUN_JAVA_NB_TEST=false \
    VSC_JUPYTER_CI_IS_CONDA=true \
    VSC_JUPYTER_CI_TEST_VSC_CHANNEL='insiders' \
    VSC_JUPYTER_CI_TEST_GREP=\"$1\" \
    npm run testNativeNotebooksInVSCode > output 2>&1"
    echo $command
    eval $command
  fi
}
function dw-activate-env {
  # Create a Python virtual environment in the root repo folder:
  python3 -m venv .venv
  # Activate the virtual environment as appropriate for your shell, For example, on bash it's...
  source .venv/bin/activate
}
function create-daily-note() {
  name=`LC_ALL=en_US.utf8 date +%Y-%m-%d-%a`
  rm -f $name.md
  # No TODO[sS], no matches for this same regexp, no lines that start with a dot
  TODOS=`grep -rin "^[^.]*TODO[^s[]" ..`
  printf "## Plan\n\n- \n\n## Notes\n\n---\n\n## TODOs\n\n$TODOS" > $name.md
}

# User Prompt
PS1="\`if [ \$? != 0 ]; then echo '\[\e[31;1m\]'; else echo '\[\e[37;1m\]'; fi\`
\u\[\e[0m\]\[\e[31;0m\] \e[31m\$(repo_or_path)\e[0m\[\e[37;1m\] \$(git_current_branch) \[\e[0m\]
"
