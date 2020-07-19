augroup vintellij_on_kt_java_file_save
  autocmd!
  autocmd BufWritePost,FileReadPost *.kt,*.java call vintellij#RefreshFile()
augroup END

augroup vintellij_on_kt_java_file_read
  autocmd!
  autocmd BufReadPost,FileReadPost *.kt,*.java call vintellij#HealthCheck()
augroup END

nnoremap <Leader>cgd :call vintellij#GoToDefinition()<CR>
nnoremap <Leader>co :call vintellij#OpenFile()<CR>
nnoremap <Leader>ci :call vintellij#SuggestImports()<CR>

