#!/bin/bash

cd ~
echo "updating apt"
sudo apt-get update -y && sudo apt-get upgrade -y

echo "installing apt packages"
sudo apt-get install kitty gnome-tweaks zathura zsh ripgrep curl git lua5.3 python3-dev python3-pip openvpn3 -y

echo "cloning git repos"
mkdir git && cd "$_"
git clone https://github.com/BubbleNeumann/dotnet.git
git clone https://github.com/BubbleNeumann/University-tasks.git
git clone https://github.com/BubbleNeumann/anime.git

cd ~
cp ~/git/dotfiles/kitty/kitty.conf ~/.config/kitty/

cp ~/git/dotfiles/.zshrc ~
source ~/.zshrc

# not sure about that
echo "install oh-my-zsh"
sh -c $(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)

# Check that rust is installed... otherwise should run this
if ! [ -x "$(command -v cargo)" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

echo "installing snap packages"
sudo snap install telegram-desktop discord bitwarden vls

sudo apt autoremove
