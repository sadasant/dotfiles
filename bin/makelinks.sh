# Make the links

ln -sf /home/sadasant/code/github/sadasant/dotfiles/.bashrc ~/.bashrc
ln -sf /home/sadasant/code/github/sadasant/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf /home/sadasant/code/github/sadasant/dotfiles/.gitconfig ~/.gitconfig
ln -sf /home/sadasant/code/github/sadasant/dotfiles/.vimrc ~/.vimrc
if [ ! -d ~/.vim ]
then
  ln -sf /home/sadasant/code/github/sadasant/dotfiles/.vim ~/.vim
fi
