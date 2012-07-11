" Highlight indentation errors (mixture of tabs and spaces etc.)
" Does accept tabs-only as valid style, however.
"let python_highlight_space_errors = 1

" Highlight builtins
let python_highlight_builtins = 1

" Trailing whitespace is an error.
hi link spaceError Error
"syn match spaceError /\s\+$/

" Leading tabs are errors in Python, as is mixing tabs and spaces.
hi link pythonSpaceError Error
"syn match pythonSpaceError /^\s*\t\s*/

" Exceeding 78 characters in a line is an Error.
"syn match Error /\%>79v.\+/


" Sub-optimal
""syn match pythonSpaceError /^\t\+/
""syn match pythonSpaceError /^\t[\t ]*\|^ \+\t\+ \+/
""syn match pythonSpaceError /^[\t ]*\t[\t ]*/
