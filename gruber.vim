syntax reset
set background=dark 
highlight clear

let g:colors_name = "gruber"

" white = #bdbdbd
" yellow = #d1bf1d
" green = #63a137
" bg black = #181818


hi CursorLine   guibg=#282828
hi CursorLineNr guifg=#d1bf1d


hi Normal       guifg=#bdbdbd guibg=#181818
hi Visual       guibg=#52494e

hi Search       guifg=#ffffff guibg=#52494e

hi PMenu        guibg=NONE
hi PMenuSel     guibg=#52494e

hi StatusLine   guibg=#181818 

hi LineNr       guifg=#52494e
hi Directory    guifg=#96a6c8


hi Identifier   guifg=#bdbdbd
hi Operator     guifg=NONE
hi Keyword      guifg=#d1bf1d gui=bold
hi Special      guifg=NONE
hi Statement    guifg=#d1bf1d

hi Function     guifg=#96a6c8 
hi Comment      guifg=#565f73
hi String       guifg=#63a137
hi PreProc      guifg=#96a6c8

hi Character    guifg=#bdbdbd
hi Constant     guifg=#95a99f
hi Type         guifg=#95a99f gui=NONE

hi NonText      guifg=#303540
hi MatchParen   guifg=#ffffff guibg=NONE

hi SignColumn   guibg=NONE

hi Todo         guifg=#d1bf1d gui=bold

hi DiffAdd        guifg=#63a137 guibg=NONE
hi DiffDelete     guifg=#c73c3f guibg=NONE
hi DiffChange     guifg=#d1bf1d guibg=NONE
hi DiffText       guifg=#2d3741 guibg=NONE

