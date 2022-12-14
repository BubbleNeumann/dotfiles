cd ~

sudo apt update -y && sudo apt upgrade -y

sudo apt install nitrogen kitty gnome-tweaks wireguard zathura zsh vim neovim -y
cp ~/git/dotfiles/kitty/kitty.conf ~/.config/kitty/

cd git
git clone https://github.com/BubbleNeumann/anime.git
git clone https://github.com/BubbleNeumann/University-tasks.git
git clone https://github.com/BubbleNeumann/Main.git
git clone https://github.com/BubbleNeumann/advent-of-code.git
cd ~

cp ~/git/dotfiles/.zshrc ~
source ~/.zshrc

# JetBrains fonts
git clone https://github.com/tjdevries/config_manager
mv ~/config_manager/fonts ~
sudo rm -r ~/config_manager

# Astronvim
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
rm -r ~/.config/nvim/
rm -r ~/nvim/
cp -r ~/git/dotfiles/astronvim/ ~/.config/nvim

# Check that rust is installed... otherwise should run this
if ! [ -x "$(command -v cargo)" ]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ! command -v rust_analyzer &> /dev/null ; then
    git clone https://github.com/rust-analyzer/rust-analyzer ~/build/rust-analyzer
    cd ~/build/rust-analyzer
    cargo xtask install --server
fi


sudo apt-get update && sudo apt-get install curl python-dev python-pip python3-dev python3-pip
sh -c $(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)

sudo apt install lua5.3
sudo snap install bitwarden discord spotify

sudo apt autoremove