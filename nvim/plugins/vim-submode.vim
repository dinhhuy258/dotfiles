" A message will be appear in the message line when you're in a submode
" and stay there until the mode has existed
let g:submode_always_show_submode = 1
let g:submode_keep_leaving_key = 1
let g:submode_timeout = 0

" Windows
call submode#enter_with('window', 'n', '', '<C-w>')
call submode#map('window', 'n', '', 'h', ':vertical resize -3<CR>')
call submode#map('window', 'n', '', 'l', ':vertical resize +3<CR>')
call submode#map('window', 'n', '', 'j', ':resize -3<CR>')
call submode#map('window', 'n', '', 'k', ':resize +3<CR>')
call submode#leave_with('window', 'n', '', '<ESC>')

