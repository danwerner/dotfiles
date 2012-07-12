" if it exists and is nonzero, then differing levels of
" parenthesization will receive different highlighting
"let g:lisp_rainbow = 1

" Highlight λ macro
syn keyword lispLambda λ
hi  link lispLambda lispFunc
