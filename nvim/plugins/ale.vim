let g:ale_disable_lsp = 1
let g:ale_enabled = 0
let g:ale_sign_error = ''
let g:ale_sign_warning = ''

let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warn'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

nnoremap <F9> :ALEToggle<CR>
