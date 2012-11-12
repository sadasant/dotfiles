# Clone all the vim plugins that I use
# inside the bundle directory

repos=(
  "chrisbra/NrrwRgn"
  "ciaranm/detectindent"
  "godlygeek/tabular"
  "scrooloose/nerdcommenter"
  "scrooloose/syntastic"
  "tpope/vim-fugitive"
  "tpope/vim-surround"
  )

cd ~/.vim/

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
    echo Exists: "${repo}"
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
    rm -fr $f
  fi
done
