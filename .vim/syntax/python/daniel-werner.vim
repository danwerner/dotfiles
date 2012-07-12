
" Highlight builtins
let python_highlight_builtins = 1
let python_highlight_builtin_objs = 1
let python_highlight_builtin_funcs = 1
let python_highlight_exceptions = 0
let python_highlight_string_formatting = 1      " %s
let python_highlight_string_format = 0          " str.format
let python_highlight_string_templates = 0       " string.Template
let python_highlight_indent_errors = 1
let python_highlight_space_errors = 1
let python_highlight_doctests = 1
"let python_highlight_all = 1

" Trailing whitespace is an error.
"hi link spaceError Error
"syn match spaceError /\s\+$/

" Leading tabs are errors in Python, as is mixing tabs and spaces.
"hi link pythonSpaceError Error
"syn match pythonSpaceError /^\s*\t\s*/

" Exceeding 78 characters in a line is an Error.
"syn match Error /\%>79v.\+/

" math
syn keyword pythonBuiltinFunc   ceil floor

" nose.tools
syn keyword pythonStatement     assert_equal assert_equals assert_not_equal assert_not_equals
syn keyword pythonStatement     assert_almost_equal assert_almost_equals assert_not_almost_equal
syn keyword pythonStatement     assert_not_almost_equals assert_true assert_false assert_raises
syn keyword pythonStatement     assert_none assert_not_none
" functools
syn keyword pythonBuiltinFunc   partial
" itertools
syn keyword pythonBuiltinFunc   chain combinations cycle dropwhile groupby
syn keyword pythonBuiltinFunc   ifilter ifilterfalse imap islice izip izip_longest
syn keyword pythonBuiltinFunc   permutations product repeat starmap takewhile tee

" functools, functionally
syn keyword pythonBuiltinFunc   cons compose complement concat const constantly delegate
syn keyword pythonBuiltinFunc   first filter_attr identity keep last mapcat maybe
syn keyword pythonBuiltinFunc   partition partition_by second some somefx thrush
