-- PHP Language Server configuration
return {
  cmd = { 'phpactor', 'language-server' },
  filetypes = { 'php' },
  root_markers = { 'composer.json', '.git' },
}