# Make the links

ln -sf /home/$USER/code/github/sadasant/dotfiles/.bashrc ~/.bashrc
ln -sf /home/$USER/code/github/sadasant/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf /home/$USER/code/github/sadasant/dotfiles/.gitconfig ~/.gitconfig
ln -sf /home/$USER/code/github/sadasant/dotfiles/.vimrc ~/.vimrc
if [ ! -d ~/.vim ]; then
  ln -sf /home/$USER/code/github/sadasant/dotfiles/.vim ~/.vim
fi

# Go Dirs
if [ ! -d ~/code/go ]; then
  mkdir ~/code/go
fi
if [ ! -d ~/code/go/src ]; then
  mkdir ~/code/go/bin
  mkdir ~/code/go/pkg
  mkdir ~/code/go/src
fi
if [ ! -d ~/code/go/github.com ]; then
  ln -sf /home/$USER/code/github/ ~/code/go/src/github.com
fi
if [ ! -d ~/code/go/bitbucket.org ]; then
  ln -sf /home/$USER/code/bitbucket/ ~/code/go/src/bitbucket.org
fi
