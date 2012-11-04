# Clone all the vim plugins that I use
# inside the bundle directory

repos=(
  "chrisbra/NrrwRgn"
  "ciaranm/detectindent"
  "godlygeek/tabular"
  "scrooloose/nerdcommenter"
  "scrooloose/syntastic"
  "tpope/vim-surround"
  )

if [ ! -d ./bundle ]
then
  mkdir bundle
fi

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
