-- Terraform Language Server configuration
return {
  cmd = { 'terraform-ls', 'serve' },
  filetypes = { 'terraform', 'tf', 'hcl' },
  root_markers = { '.terraform', '.git' },
}