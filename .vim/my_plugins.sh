# Clone all the vim plugins that I use
# inside the bundle directory

repos=(
  "chrisbra/histwin.vim"
  "coderifous/textobj-word-column.vim"
  "godlygeek/tabular"
  "gregsexton/MatchTag"
  "jnwhiteh/vim-golang"
  "mattn/zencoding-vim"
  "michaeljsmith/vim-indent-object"
  "sandeepcr529/Buffet.vim"
  "scrooloose/syntastic"
  "tpope/vim-fugitive"
  "tpope/vim-surround"
  )

cd ~/code/github/sadasant/dotfiles/.vim

if [ ! -d ./bundle ]
then
  mkdir bundle
fi

# Cloning New Repos
cd bundle
for repo in "${repos[@]}"
do
  repo_name=`echo ${repo} | cut -d '/' -f 2`
  if [ -d $repo_name ]
  then
    echo "${repo}" Exists!
    read -p "Do you wish to update ${repo}? " yn
    case $yn in
      [Yy]* ) echo Updating...;
              cd $repo_name;
              git fetch origin;
              git rebase -p origin/master;
              cd ..;;
    esac
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
