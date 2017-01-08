" No Compatibility. That just sucks
" especially annoying on redhat/windows/osx
set nocompatible
set backspace=indent,eol,start

" Menus I like :-)
" ----------------
" This must happen before the syntax system is enabled
aunmenu Help.
aunmenu Window.
let no_buffers_menu=1
set mousemodel=popup

" Support for yankring
set viminfo+=!

" Enable Syntax Colors
" --------------------
"  in GUI mode we go with fruity and Monaco 12
"  in CLI mode desert looks better (fruity is GUI only)
syntax on
if has("gui_running")
  colorscheme fruity
  set guifont=Monaco:h12
else
  colorscheme desert
endif

" My PC is fast enough, do syntax highlight syncing from start
autocmd BufEnter * :syntax sync fromstart

" Move Backup Files to ~/.vim/sessions
" ------------------------------------
set backupdir=~/.vim/sessions
set dir=~/.vim/sessions

" Some File Type Stuff
" --------------------
"  Enable filetype plugins and indention
filetype on
filetype plugin on

" Highlight NBSP
" --------------
"  wanna see them
function! HighlightNonBreakingSpace()
  syn match suckingNonBreakingSpace " " containedin=ALL
  hi suckingNonBreakingSpace guibg=#157249
endfunction
autocmd BufEnter * :call HighlightNonBreakingSpace()

" File Templates
" --------------
"  ^J jumps to the next marker
function! LoadFileTemplate()
  silent! 0r ~/.vim/templates/%:e.tmpl
  syn match vimTemplateMarker "<+.\++>" containedin=ALL
  hi vimTemplateMarker guifg=#67a42c guibg=#112300 gui=bold
endfunction
function! JumpToNextPlaceholder()
  let old_query = getreg('/')
  echo search("<+.\\++>")
  exec "norm! c/+>/e\<CR>"
  call setreg('/', old_query)
endfunction
autocmd BufNewFile * :call LoadFileTemplate()
nnoremap <C-J> :call JumpToNextPlaceholder()<CR>a
inoremap <C-J> <ESC>:call JumpToNextPlaceholder()<CR>a

" Leader
" ------
" sets leader to ',' and localleader to "\"
let mapleader=","
let maplocalleader="\\"

" User Interface
" --------------
" activate wildmenu, permanent ruler and disable Toolbar, and add line
" highlightng as well as numbers.
" And disable the sucking pydoc preview window for the omni completion
" also highlight current line and disable the blinking cursor.
set wildmenu
set ruler
set guioptions-=T
set completeopt-=preview
set gcr=a:blinkon0

" Set Better Indention
" --------------------
"  go with smartindent if there is no plugin indent file.
"  but don't outdent hashes
set smartindent
inoremap # X#

" Statusbar and Linenumbers
" -------------------------
"  Make the command line two lines heigh and change the statusline display to
"  something that looks useful.
set cmdheight=2
set laststatus=2
set statusline=[%l,%c\ %P%M]\ %f\ %r%h%w
set number

" Tab Settings
" ------------
set smarttab
set tabstop=8

" Tab page settings
" -----------------
function! GuiTabLabel()
  let label = ''
  let buflist = tabpagebuflist(v:lnum)
  if exists('t:title')
    let label .= t:title . ' '
  endif
  let label .= '[' . bufname(buflist[tabpagewinnr(v:lnum) - 1]) . ']'
  for bufnr in buflist
    if getbufvar(bufnr, '&modified')
      let label .= '+'
      break
    endif
  endfor
  return label
endfunction
set guitablabel=%{GuiTabLabel()}

" utf-8 default encoding
" ----------------------
set enc=utf-8

" Toggle Comments
" ---------------
"  toggle comments on alt+c
source ~/.vim/scripts/FeralToggleCommentify.vim

" python support
" --------------
"  don't highlight exceptions and builtins. I love to override them in local
"  scopes and it sucks ass if it's highlighted then. And for exceptions I
"  don't really want to have different colors for my own exceptions ;-)
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
let python_highlight_all=1
let python_highlight_exceptions=0
let python_highlight_builtins=0

" ruby support
" ------------
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" php support
" -----------
autocmd FileType php setlocal shiftwidth=8 tabstop=8 softtabstop=8

" template language support (SGML / XML too)
" ------------------------------------------
"  and disable taht stupid html rendering (like making stuff bold etc)

fun! s:SelectHTML()
  let n = 1
  while n < 50 && n < line("$")
    " check for jinja
    if getline(n) =~ '{%\s*\(extends\|block\|macro\|set\|if\|for\|include\|trans\)\>'
      set ft=htmljinja
      return
    endif
    " check for django
    if getline(n) =~ '{%\s*\(extends\|block\|comment\|ssi\|if\|for\|blocktrans\)\>'
      set ft=htmldjango
      return
    endif
    " check for mako
    if getline(n) =~ '<%\(def\|inherit\)'
      set ft=mako
      return
    endif
    " check for genshi
    if getline(n) =~ 'xmlns:py\|py:\(match\|for\|if\|def\|strip\|xmlns\)'
      set ft=genshi
      return
    endif
    let n = n + 1
  endwhile
  " go with html
  set ft=html
endfun

autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufNewFile,BufRead *.rhtml setlocal ft=eruby
autocmd BufNewFile,BufRead *.mako setlocal ft=mako
autocmd BufNewFile,BufRead *.tmpl setlocal ft=htmljinja
autocmd BufNewFile,BufRead *.py_tmpl setlocal ft=python
autocmd BufNewFile,BufRead *.html,*.htm  call s:SelectHTML()
let html_no_rendering=1

let g:closetag_default_xml=1
autocmd FileType html,htmldjango,htmljinja,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,htmljinja,eruby,mako source ~/.vim/scripts/closetag.vim

" CSS
" ---
autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" Java
" ----
autocmd FileType java setlocal shiftwidth=4 tabstop=4 softtabstop=4

" rst
" ---
autocmd BufNewFile,BufRead *.txt setlocal ft=rst
autocmd FileType rst setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" C#
autocmd FileType cs setlocal tabstop=8 softtabstop=8 shiftwidth=8

" vim
" ---
autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=8 softtabstop=2

" Javascript
" ----------
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
let javascript_enable_domhtmlcss=1

" D
" -
autocmd FileType d setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4

" File Browser
" ------------
" hide some files and remove stupid help
let g:explHideFiles='^\.,.*\.sw[po]$,.*\.pyc$'
let g:explDetailedHelp=0
map  :Explore!<CR>

" Better Search
" -------------
set hlsearch
set incsearch

" Minibuffer
" ----------
"  one click is enough and fix some funny bugs
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapCTabSwitchBufs = 1

" BufClose
" --------
"  map :BufClose to :bq and ^B and configure it to open a file browser on close
let g:BufClose_AltBuffer = '.'
cnoreabbr <expr> bq 'BufClose' 
map  :BufClose<CR>

" Copy to Lodgeit on ^L
" ---------------------
map  :Lodgeit<CR>
