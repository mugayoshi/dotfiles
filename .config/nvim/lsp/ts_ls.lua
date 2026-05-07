return {
  cmd = {'typescript-language-server', '--stdio'},
  filetypes = { 'typescript' },
  -- This is a hint to tell nvim to find your project root from a file within the tree
  root_dir = vim.fs.root(0, {'package.json', '.git'}),
  on_attach = on_attach,
  capabilities = capabilities,
}
