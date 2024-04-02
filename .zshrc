export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="imp"

plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

alias vim='nvim'

# vpn
alias wgup='sudo wg-quick up frankfurt'
alias wgdown='sudo wg-quick down frankfurt'
alias startvpn='sudo systemctl start strongswan-starter'
alias stopvpn='sudo systemctl stop strongswan-starter'

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

# git 
alias gp='~/git/dotfiles/configs/gitpush.sh'

# autosuggestions
bindkey '^ ' autosuggest-accept

