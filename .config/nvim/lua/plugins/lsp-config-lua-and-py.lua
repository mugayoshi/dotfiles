-- only applicable with Nvim0.11+
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
	      ensure_installed = { "lua_ls", "pyright" }
    	})
    end
 },
 {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      tim.lsp.enable('lua_ls')
      vim.lsp.config('lua_ls', {
        capabilities = capabilities
      })
      vim.lsp.enable('pyright')
      vim.lsp.config('pyright', {
        capabilities = capabilities,
        filetypes = { "python" }
      })

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
	    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
	    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action ,{})
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
    end
 }
}
