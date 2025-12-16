return {
 {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
 },
 {
    "williamboman/mason-lspconfig.nvim",
    config = function()
	    require("mason-lspconfig").setup({
	      ensure_installed = { "lua_ls", "gopls", "pyright", "ts_ls", "svelte" }
    	})
    end
 },
 {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local util = require("lspconfig/util")

	    local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.gopls.setup({
        capabilities = capabilities,
        cmd = {"gopls"},
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_dir = util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
            },
          },
        },
      })
      lspconfig.pyright.setup({
        capabilities = capabilities,
        filetypes = { "python" }
      })
      lspconfig.ts_ls.setup({})
      lspconfig.svelte.setup({})

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
	    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
	    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action ,{})
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
    end
 }
}
