local vue = require('vue')
local ts_ls_config = {
  init_options = {
    plugins = { vue.ts_plugin },
  },
  filetypes = vue.filetypes,
}

return vim.tbl_extend('force', ts_ls_config, {
  cmd = { 'typescript-language-server', '--stdio' },
  -- This is a hint to tell nvim to find your project root from a file within the tree
  root_dir = vim.fs.root(0, { 'package.json', '.git' }),
  on_attach = on_attach,
  capabilities = capabilities,
})
