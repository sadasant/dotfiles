#!/bin/bash
# Clone all the vim plugins that I use
# inside the bundle directory

repos=(
  "chrisbra/histwin.vim"
  "elzr/vim-json"
  "fatih/vim-go"
  "gregsexton/MatchTag"
  "junegunn/vim-easy-align"
	"leafgarland/typescript-vim"
  "mattn/emmet-vim"
  "pangloss/vim-javascript"
  "plasticboy/vim-markdown"
  "roxma/vim-tmux-clipboard"
  "sandeepcr529/Buffet.vim"
	"sbdchd/neoformat"
  "Shougo/deoplete.nvim"
  "tmux-plugins/vim-tmux-focus-events"
  "tpope/vim-fugitive"
  "tpope/vim-surround"
	"vim-scripts/repmo.vim"
	"w0rp/ale"
  )

cd ~/code/github/sadasant/dotfiles/.vim

if [ ! -d ./bundle ]
then
  mkdir bundle
fi

# Ask before updating?
quiet=false
case "$1" in
  -quiet) quiet=true
esac

# Cloning New Repos
cd bundle
for repo in "${repos[@]}"
do
  repo_name=`echo ${repo} | cut -d '/' -f 2`
  if [ -d $repo_name ]
  then
    echo "${repo}" Exists!
      if [ $quiet == false ]; then
        read -p "Do you want to update ${repo}? " yn
        case $yn in
          [Yy]* ) echo Updating...;;
          *     ) continue;;
        esac
      else
        echo Updating...
      fi
      cd $repo_name;
      git fetch origin;
      git rebase -p origin/master;
      cd ..
  else
    git clone git://github.com/"${repo}".git
  fi
done

# Removing Unlisted Repos
for f in *
do
  ok=0
  for repo in "${repos[@]}"
  do
    repo_name=`echo ${repo} | cut -d '/' -f 2`
    [ $f == $repo_name ] && ok=1
  done
  if [ $ok == 0 ]
  then
    echo Removing: $f
    rm -fr $f
  fi
done

# Updating Pathogen
echo Deleting Old Pathogen
cd ..
cd ./autoload
rm pathogen.vim
echo Downloading Pathogen
wget https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
cd ..
