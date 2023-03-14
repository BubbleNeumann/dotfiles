export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

alias wgup='sudo wg-quick up frankfurt'
alias wgdown='sudo wg-quick down frankfurt'
alias main='cd ~ && nvim ~/git/Main/'
alias aoc21='nvim ~/git/advent-of-code/2021'
alias aoc22='nvim ~/git/advent-of-code/2022'
alias uni='nvim ~/git/University-tasks/'
alias conf='nvim ~/.config/nvim/'

alias ~='cd ~'
alias ..='cd ..'
alias ls='exa -a'
alias tree='exa -T'
alias top='ytop'

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
