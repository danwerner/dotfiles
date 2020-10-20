" My personal sh/bash/zsh settings

set shiftwidth=2        " autoindent width
set tabstop=8
set softtabstop=4       " editing
set expandtab           " tabs -> spaces
set smarttab            " do not use tabs + spaces
set autoindent          " copy indent from previous line
set nosmartindent       " detrimental to Python code due to syntax
set nocindent           " cindent is NOT smart

nmap <buffer> <F9>  :!sh %<CR>
