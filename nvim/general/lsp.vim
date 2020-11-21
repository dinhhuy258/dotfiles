lua <<EOF

local nvim_lsp = require'nvim_lsp'

local on_attach_nvim = function(client)
  require'completion'.on_attach(client)
  require'diagnostic'.on_attach(client)
end

nvim_lsp.jdtls.setup{
  root_dir = nvim_lsp.util.root_pattern('.git', 'pom.xml', 'build.xml', 'build.gradle'),
  on_attach = on_attach_nvim
}

EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_enable_auto_popup = 1
let g:completion_trigger_keyword_length = 2
let g:completion_trigger_on_delete = 0
let g:completion_matching_ignore_case = 0
let g:completion_trigger_character = ['.', '::', '->']
let g:completion_confirm_key = "\<CR>"
let g:completion_enable_auto_hover = 1
let g:completion_enable_auto_signature = 1
let g:completion_sorting = "alphabet"
let g:completion_matching_strategy_list = ['exact']
let g:completion_timer_cycle = 200

let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_virtual_text_prefix = ''
let g:diagnostic_trimmed_virtual_text = '150'
let g:space_before_virtual_text = 1
let g:diagnostic_show_sign = 1
let g:diagnostic_sign_priority = 20
let g:diagnostic_enable_underline = 1
let g:diagnostic_auto_popup_while_jump = 1
let g:diagnostic_insert_delay = 0
call sign_define("LspDiagnosticsErrorSign", {"text" : "", "texthl" : "LspDiagnosticsError"})
call sign_define("LspDiagnosticsWarningSign", {"text" : "", "texthl" : "LspDiagnosticsWarning"})
call sign_define("LspDiagnosticsInformationSign", {"text" : "", "texthl" : "LspDiagnosticsInformation"})
call sign_define("LspDiagnosticsHintSign", {"text" : "", "texthl" : "LspDiagnosticsHint"})

nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gy <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
