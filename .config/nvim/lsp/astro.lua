---@brief
---
--- https://github.com/withastro/language-tools/tree/main/packages/language-server
---
--- `astro-ls` can be installed via `npm`:
--- ```sh
--- npm install -g @astrojs/language-server
--- ```

---@type vim.lsp.Config
return {
  cmd = { 'astro-ls', '--stdio' },
  filetypes = { 'astro' },
  root_markers = { 'package.json', 'tsconfig.json', 'jsconfig.json', '.git' },
  init_options = {
    typescript = {
      -- You can find the tsdk path by running `npm root -g` and appending `/typescript/lib` to the path of astro language server.
      tsdk = '/opt/homebrew/lib/node_modules/@astrojs/language-server/node_modules/typescript/lib'
    },
  },
}
