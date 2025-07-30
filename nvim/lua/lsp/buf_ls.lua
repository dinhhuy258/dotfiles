-- Protocol Buffer Language Server configuration
return {
  cmd = { 'bufls', 'serve' },
  filetypes = { 'proto' },
  root_markers = { 'buf.yaml', 'buf.json', '.git' },
}