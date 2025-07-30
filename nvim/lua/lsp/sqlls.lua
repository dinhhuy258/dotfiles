-- SQL Language Server configuration
return {
  cmd = { 'sql-language-server', 'up', '--method', 'stdio' },
  filetypes = { 'sql' },
  root_markers = { '.git' },
}