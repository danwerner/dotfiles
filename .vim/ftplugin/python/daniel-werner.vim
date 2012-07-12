" Python-specific settings -- Daniel Werner
setlocal shiftwidth=4        " autoindent width
setlocal softtabstop=4       " editing
setlocal tabstop=8           " tab characters HAVE width 8, so don't use them
setlocal expandtab           " tabs -> spaces
setlocal smarttab            " do not use tabs + spaces
setlocal autoindent          " copy indent from previous line
setlocal nosmartindent       " detrimental to Python code due to syntax
setlocal nocindent           " cindent is NOT smart

nmap <buffer> <F8>       :!pyflakes %<CR>
nmap <buffer> <F9>       :!python %<CR>

autocmd FileType python set omnifunc=pythoncomplete#Complete
