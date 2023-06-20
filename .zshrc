export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

alias vim='nvim'

# vpn
alias wgup='sudo wg-quick up frankfurt'
alias wgdown='sudo wg-quick down frankfurt'

# navigation
alias main='cd ~/git/Main/ && nvim .'
alias conf='nvim ~/.config/nvim/'

# system
alias upd='sudo apt update -y && sudo apt upgrade -y'
alias ~='cd ~'
alias ..='cd ..'
alias ls='exa -a'
alias tree='exa -T'
alias top='ytop'

# twitch
alias acorn='xdg-open https://twitch.tv/acorn1010'
alias prime='xdg-open https://twitch.tv/theprimeagen'

# c / cpp
alias cpp='clang++ -o out && ./out'
alias c='clang -o out && ./out'

# browser bookmarks
alias cf='xdg-open https://codeforces.com/'

# autosuggestions
bindkey '^ ' autosuggest-accept
