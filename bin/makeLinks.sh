#!/bin/bash
# Make the links

ln -sf $HOME/code/github.com/sadasant/dotfiles/.bashrc $HOME/.bashrc
ln -sf $HOME/code/github.com/sadasant/dotfiles/.inputrc $HOME/.inputrc
ln -sf $HOME/code/github.com/sadasant/dotfiles/.tmux.conf $HOME/.tmux.conf
ln -sf $HOME/code/github.com/sadasant/dotfiles/.tmux.vb.conf $HOME/.tmux.vb.conf
ln -sf $HOME/code/github.com/sadasant/dotfiles/.gitconfig $HOME/.gitconfig
ln -sf $HOME/code/github.com/sadasant/dotfiles/.asoundrc $HOME/.asoundrc

# vim dirs
ln -sf $HOME/code/github.com/sadasant/dotfiles/.vimrc $HOME/.vimrc
if [ ! -d $HOME/.vim ]; then
  ln -sf $HOME/code/github.com/sadasant/dotfiles/.vim $HOME/.vim
fi

# uzbl dirs
if [ ! -d $HOME/.config ]; then
  mkdir $HOME/.config
fi
if [ ! -d $HOME/.config/uzbl ]; then
  ln -sf $HOME/code/github.com/sadasant/dotfiles/.config/uzbl $HOME/.config/uzbl
fi
if [ -d $HOME/.config/fish ]; then
  ln -sf $HOME/code/github.com/sadasant/dotfiles/.config/fish/config.fish $HOME/.config/fish/config.fish
fi

# go dirs
if [ ! -d $HOME/code/go ]; then
  mkdir $HOME/code/go
fi
if [ ! -d $HOME/code/go/src ]; then
  mkdir $HOME/code/go/bin
  mkdir $HOME/code/go/pkg
  mkdir $HOME/code/go/src
fi
if [ ! -d $HOME/code/go/src/github.com ]; then
  ln -sf $HOME/code/github.com $HOME/code/go/src/github.com
fi
if [ ! -d $HOME/code/go/src/bitbucket.org ]; then
  ln -sf $HOME/code/bitbucket.org $HOME/code/go/src/bitbucket.org
fi
