export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

# User configuration

alias wgup='sudo wg-quick up frankfurt'
alias wgdown='sudo wg-quick down frankfurt'
alias nvim='./squashfs-root/usr/bin/nvim'
alias rust='cd ~ && nvim ~/git/rust-experiments/'
alias main='cd ~ && nvim ~/git/Main/'
alias aoc21='cd ~ && nvim ~/git/advent-of-code/2021'
alias aoc22='cd ~ && nvim ~/git/advent-of-code/2022'
alias game='cd ~ && nvim ~/cthulhu-game/Assets/Scripts/'

alias ~='cd ~'
alias ..='cd ..'
alias ls='ls -a'

# twitch
alias acorn='xdg-open https://twitch.tv/acorn1010'
alias prime='xdg-open https://twitch.tv/theprimeagen'

# c / cpp
alias cpp='clang++ -o out'
alias c='clang -o out'
alias run='./out'

# browser bookmarks
alias cf='xdg-open https://codeforces.com/'

# autosuggestions
bindkey '^ ' autosuggest-accept
