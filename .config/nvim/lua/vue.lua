local M = {}

M.language_server_path = vim.fn.system('mise exec -- npm root -g'):gsub('%s+$', '') .. '/@vue/language-server'
M.filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
M.ts_plugin = {
  name = '@vue/typescript-plugin',
  location = M.language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

return M
