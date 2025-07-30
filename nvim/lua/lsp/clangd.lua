-- C/C++ Language Server configuration
return {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto' },
  root_markers = { '.clangd', 'compile_commands.json', 'compile_flags.txt', '.git' },
}