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
        -- remove comment if astro is required
	      -- ensure_installed = { "astro", "lua_ls", "pyright" }
	      ensure_installed = { "lua_ls", "pyright" }
    	})
    end
 },
 {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- remove comment if astro is required
      -- vim.lsp.enable('astro')

      vim.lsp.enable('lua_ls')
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
