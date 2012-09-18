# Clone all the vim plugins that I use
# inside the bundle directory

repos=(
  "scrooloose/syntastic"
  "godlygeek/tabular"
  "tpope/vim-surround"
  "ciaranm/detectindent"
  )

if [ ! -d ./bundle ]
then
  mkdir bundle
fi

cd bundle
for repo in "${repos[@]}"
do
  repo_name=`echo ${repo} | cut -d '/' -f 2`
  if [ ! -d ./bundle/$repo_name ]
  then
    git clone git@github.com:"${repo}"
  else
    echo Exists: "${repo}"
  fi
done
