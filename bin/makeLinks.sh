#!/bin/bash
# Make the links

ln -sf /home/$USER/code/github/sadasant/dotfiles/.bashrc /home/$USER/.bashrc
ln -sf /home/$USER/code/github/sadasant/dotfiles/.inputrc /home/$USER/.inputrc
ln -sf /home/$USER/code/github/sadasant/dotfiles/.tmux.conf /home/$USER/.tmux.conf
ln -sf /home/$USER/code/github/sadasant/dotfiles/.tmux.vb.conf /home/$USER/.tmux.vb.conf
ln -sf /home/$USER/code/github/sadasant/dotfiles/.gitconfig /home/$USER/.gitconfig
ln -sf /home/$USER/code/github/sadasant/dotfiles/.asoundrc /home/$USER/.asoundrc

# vim dirs
ln -sf /home/$USER/code/github/sadasant/dotfiles/.vimrc /home/$USER/.vimrc
if [ ! -d /home/$USER/.vim ]; then
  ln -sf /home/$USER/code/github/sadasant/dotfiles/.vim /home/$USER/.vim
fi

# uzbl dirs
if [ ! -d /home/$USER/.config ]; then
  mkdir /home/$USER/.config
fi
if [ ! -d /home/$USER/.config/uzbl ]; then
  ln -sf /home/$USER/code/github/sadasant/dotfiles/.config/uzbl /home/$USER/.config/uzbl
fi
if [ -d /home/$USER/.config/fish ]; then
  ln -sf /home/$USER/code/github/sadasant/dotfiles/.config/fish/config.fish /home/$USER/.config/fish/config.fish
fi

# go dirs
if [ ! -d /home/$USER/code/go ]; then
  mkdir /home/$USER/code/go
fi
if [ ! -d /home/$USER/code/go/src ]; then
  mkdir /home/$USER/code/go/bin
  mkdir /home/$USER/code/go/pkg
  mkdir /home/$USER/code/go/src
fi
if [ ! -d /home/$USER/code/go/src/github.com ]; then
  ln -sf /home/$USER/code/github /home/$USER/code/go/src/github.com
fi
if [ ! -d /home/$USER/code/go/src/bitbucket.org ]; then
  ln -sf /home/$USER/code/bitbucket /home/$USER/code/go/src/bitbucket.org
fi
