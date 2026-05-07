local vue = require('vue')

return {
  cmd = { 'vue-language-server', '--stdio' },
  filetypes = { 'vue' },
  root_dir = vim.fs.root(0, { 'package.json', '.git' }),
  init_options = {
    typescript = {
      tsdk = vue.language_server_path .. '/node_modules/typescript/lib',
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
  on_init = function(client)
    client.handlers['tsserver/request'] = function(_, result, context)
      local ts_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'ts_ls' })
      local vtsls_clients = vim.lsp.get_clients({ bufnr = context.bufnr, name = 'vtsls' })
      local clients = {}

      vim.list_extend(clients, ts_clients)
      vim.list_extend(clients, vtsls_clients)

      if #clients == 0 then
        vim.notify(
          'Could not find `vtsls` or `ts_ls` lsp client, `vue_ls` would not work without it.',
          vim.log.levels.ERROR
        )
        return
      end
      local ts_client = clients[1]

      local param = unpack(result)
      local id, command, payload = unpack(param)
      ts_client:exec_cmd({
        title = 'vue_request_forward',
        command = 'typescript.tsserverRequest',
        arguments = { command, payload },
      }, { bufnr = context.bufnr }, function(_, r)
        local response = r and r.body
        local response_data = { { id, response } }
        ---@diagnostic disable-next-line: param-type-mismatch
        client:notify('tsserver/response', response_data)
      end)
    end
  end,
}
