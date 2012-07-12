" .vimrc
" Daniel Werner

set nocompatible

" Pathogen
filetype off
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()

syntax on

" My PC is fast enough, do syntax highlight syncing from start
autocmd BufEnter * :syntax sync fromstart

" Move Backup Files to ~/.vim/sessions
" ------------------------------------
set backupdir=~/.vim/sessions
set dir=~/.vim/sessions

filetype on
if has("autocmd")
  filetype plugin on
  filetype indent on
endif

" Highlight NBSP
" --------------
"  wanna see them
function! HighlightNonBreakingSpace()
  syn match suckingNonBreakingSpace " " containedin=ALL
  hi suckingNonBreakingSpace guibg=#157249
endfunction
autocmd BufEnter * :call HighlightNonBreakingSpace()

syntax on

augroup filetype
	au BufRead reportbug.*		set ft=mail
	au BufRead reportbug-*		set ft=mail
augroup END

" Spell/Syntax checker
" defaults -- change if desired
"if has("gui_running")
"  highlight SpellBad term=underline gui=undercurl guisp=Red
"endif

" Leader
" ------
" sets leader to ',' and localleader to "\"
let mapleader=","
let maplocalleader="\\"

" Preferences
set shortmess=filmnrxOsI
"set ignorecase				" case insens. search
set history=100
"set confirm
set clipboard+=unnamed
set ffs=unix,dos,mac		" order is significant
set iskeyword+=_,$,@,%,#,-


"Thank you FunnyMan3595
"http://www.reddit.com/r/programming/comments/9wlb7/proggitors_do_you_like_the_idea_of_indented/c0esam1
set list
set lcs=tab:»·   "show tabs
set lcs+=trail:· "show trailing spaces

" Aides
set showmatch			" show matching brackets
set matchtime=5			" for 1/2 second
set incsearch			" highlight while typing
set scrolloff=3			" scroll when x lines from border
"set statusline=%F%M%r%h%w\ %{&ff}\ %y\ %02.2B\ %03.3b\ %l,%c%v/%L\ \ %p%%
set statusline=%F%M%r%h%w\ %{&ff}\ %y\ %02.2B\ %03.3b\ %{fugitive#statusline()}\ %l,%c%V/%L\ \ %p%%
set formatoptions=tcr2M1	" fo-table


" UI
set showcmd
set linespace=0
set wildmenu
set ruler
"set cmdheight=2
set lazyredraw
set hidden			" hide buffers instead of unloading them
set backspace=2			" backspace=indent,eol, start
set mouse=vhr			" visual, help, hit-r-prompts
set report=0			" always report lines
"set noerrorbells		" stop annoying noise
set visualbell			" use visual bell
set fillchars=vert:\|,stl:\ ,stlnc:\ 
set hlsearch			" hls

nmap <C-H> :nohls<CR>


" Files & Backups
set nobackup
set writebackup
set directory=~/tmp,.,/var/tmp,/tmp


" Theme
" Replace programmer's highlights by respective lighter color.
"set background=dark
set background=light
"highlight Comment	ctermfg=LightBlue
"highlight Constant	ctermfg=Red
"highlight Statement	ctermfg=Yellow
"highlight Identifier	ctermfg=Cyan
"highlight SpecialKey	ctermfg=Blue
" Search highlighting and visual readable at last
"highlight Search	term=underline cterm=underline ctermfg=White ctermbg=NONE
"highlight Visual	term=underline cterm=underline


" Tabs & Indent
set shiftwidth=8		" autoindent width
set tabstop=8			" tab char = ts
set softtabstop=8		" tab char = ts (editing)
set noexpandtab			" tabs -> spaces
set smarttab			" do not use tabs + spaces
set autoindent			" copy indent from previous line
set smartindent			" detrimental to Python code?
set nocindent			" cindent is NOT smart

" Wrapping
"set textwidth=78		" cause of too many problems
set textwidth=0
set wrap			" visual line wrapping (doesn't change buffer)
set wrapmargin=0
"set joinspaces			" insert 2x' ' after .?! on join

" Pasting
"set pastetoggle=<f11>

" http://www.reddit.com/r/vim/comments/pkwkm/awesome_little_tweak_automatically_reindent_on/
"nnoremap <leader>p p
"nnoremap <leader>P P
"nnoremap p p'[v']=
"nnoremap P P'[v']=

" Folding
set foldenable
set foldmethod=indent
set foldlevel=100		" don't autofold
set foldopen-=search
set foldopen-=undo

" Make p in Visual mode replace the selected text with the "" register.
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" CTags
"let Tlist_Ctags_Cmd = $VIM.'\ctags.exe'	" Location of ctags
"let Tlist_Sort_Type = "name"		" order by 
"let Tlist_Use_Right_Window = 1		" split to the right side of the screen
"let Tlist_Compart_Format = 1		" show small meny
"let Tlist_Exist_OnlyWindow = 1		" if you are the last, kill yourself
"let Tlist_File_Fold_Auto_Close = 0	" Do not close tags for other files
"let Tlist_Enable_Fold_Column = 0	" Do not show folding tree

" Make trailing whitespace visible.
" FIXME I do not wish to see tabs.
"set list
"set listchars=tab:\ \ ,trail:-

" Minibuf
let g:miniBufExplTabWrap = 1 	" make tabs show complete
				" (no broken on two lines)
let g:miniBufExplModSelTarget = 1

" Matchit
let b:match_ignorecase = 1

" Perl
let perl_extended_vars=1 " highlight advanced perl vars inside strings

" File Explorer
let g:explVertical=1		" should I split verticially
let g:explWinSize=35		" width of 35 pixels

" Win Manager
let g:winManagerWidth=35	" How wide should it be (pixels)
let g:winManagerWindowLayout ='FileExplorer,TagsExplorer|BufExplorer'

" Make Shift+Insert work like Pointer Button 2 in xterm & co.
imap <S-Insert> <MiddleMouse>

" Quick paragraph formatting
nmap Q gqap

" aspell
noremap <F7>    :w!<CR>:!aspell check %<CR>:e! %<CR>

" Programming
"nmap    <F5>    :!sudo service apache2 restart<CR><CR>
nmap    <F5>    :!touch lib/wsgi/mod_wsgi.py<CR><CR>
nmap    <F9>    :make %<CR>
nmap    <C-F9>  :make

" Tabs
nmap gn  :tabnew<CR>
nmap gc  :tabc<CR>

" Syntastic

" Use the |:sign| interface to mark syntax errors
let g:syntastic_enable_signs=1

" When set to 1 the error window will be automatically
" opened when errors are detected, and closed when none
" are detected.
let g:syntastic_auto_loc_list=1

" Haskell - SHIM
let g:shim_ghciPrompt = "^ghci>"
let g:shim_defaultWindowSize = 10

autocmd FileType haskell nmap <LocalLeader>e :GhciRange<CR>
autocmd FileType haskell vmap <LocalLeader>e :GhciRange<CR>
autocmd FileType haskell nmap <LocalLeader>f :GhciFile<CR>
autocmd FileType haskell nmap <LocalLeader>r :GhciReload<CR>

"nmap <M-[> :prev<CR>
"nmap <M-]> :next<CR>

"""""""""""""""
" Tipps by: Wouter Bolsterlee, also known as
"           uws, a postmodern geek living in the Netherlands.
"           http://uwstopia.nl/blog/2005/08/vim-rocks-my-world

" adds different types of quotes around the current word
" nnoremap ,` mxbi`<Esc>ea`<Esc>`xl
" nnoremap ,' mxbi'<Esc>ea'<Esc>`xl
" nnoremap ," mxbi"<Esc>ea"<Esc>`xl

" To delete eveything between (but not including) parentheses, hit di(. To
" delete a paragraph, hit dap. The following mappings make this feature work
" for quoted strings too, so that ci" lets you replace a quoted string with
" a new one.

" Quote motions for operators: da" will delete a quoted string.
" omap i" :normal vT"ot"<CR>
" omap a" :normal vF"of"<CR>
" omap i' :normal vT'ot'<CR>
" omap a' :normal vF'of'<CR> 
" omap i` :normal vT`ot`<CR>
" omap a` :normal vF`of`<CR> 
