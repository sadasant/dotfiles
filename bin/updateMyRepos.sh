#!/bin/bash
## Update all my repos according to my git hosting providers

declare -A providers
providers[bitbucket]="/home/$USER/code/bitbucket/sadasant/"
providers[github]="/home/$USER/code/github/sadasant/"

# Ask before updating?
quiet=false
case "$1" in
  -quiet) quiet=true
esac

echo "" # Empty new line
echo To update without asking
echo -e "    \033[0;32mupdateMyRepos.sh -quiet\033[0m"

# Change dir to my repos at bitbucket
for prov in "${!providers[@]}"; do
  cd "${providers[$prov]}"
  echo "" # Empty new line
  echo -e "\033[1;37m$prov\033[0m"
  echo "" # Empty new line
  for repo in *; do
    if [ -d $repo ]; then
      echo -e "\033[0;34m- Repo: \033[1;34m$repo\033[0m"
      if [ $quiet == false ]; then
        read -p "Do you wish to update ${repo}? " yn
        case $yn in
          [Yy]* ) echo Updating...;;
          *     ) continue;;
        esac
      fi
      cd $repo
      git fetch origin
      git rebase -p origin/master
      cd ..
    fi
  done
done

