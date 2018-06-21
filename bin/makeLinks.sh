#!/bin/bash
# Make the links

ln -sf $HOME/code/github.com/sadasant/dotfiles/.bashrc $HOME/.bashrc
ln -sf $HOME/code/github.com/sadasant/dotfiles/.inputrc $HOME/.inputrc
ln -sf $HOME/code/github.com/sadasant/dotfiles/.tmux.conf $HOME/.tmux.conf
ln -sf $HOME/code/github.com/sadasant/dotfiles/.tmux.vb.conf $HOME/.tmux.vb.conf
ln -sf $HOME/code/github.com/sadasant/dotfiles/.gitconfig $HOME/.gitconfig
ln -sf $HOME/code/github.com/sadasant/dotfiles/.eslintrc $HOME/.eslintrc

# vim dirs
ln -sf $HOME/code/github.com/sadasant/dotfiles/.vimrc $HOME/.vimrc
if [ ! -d $HOME/.vim ]; then
  ln -sf $HOME/code/github.com/sadasant/dotfiles/.vim $HOME/.vim
fi
if [ ! -d $HOME/.config ]; then
  mkdir $HOME/.config
  ln -s $HOME/.vim $HOME/.config/nvim
  # ln -s $HOME/.vimrc $HOME/.config/nvim/init.vim
fi
