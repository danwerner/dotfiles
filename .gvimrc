" .gvimrc

highlight Normal guifg=gray90 guibg=black
set background=dark

" set background=light

" gvim UI
set guifont=Monospace\ 11
set guioptions=acig	" no menu, no toolbar
set mouse=a

" Disable cursor blinking
set guicursor+=a:blinkon0

" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Also switch on highlighting the last used search pattern.
if has("syntax") && (&t_Co > 2 || has("gui_running"))
	syntax on
	set hlsearch
endif

