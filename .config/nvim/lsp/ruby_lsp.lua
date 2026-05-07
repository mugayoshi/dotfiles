-- on Linux and macOS the default location is ~/.config/nvim/lsp/ruby-lsp.lua
return {
  cmd = { "mise", "exec", "--", "ruby-lsp" },
  cmd_env = {
    -- see ruby_lsp_setup.md for the details
    RUBY_LSP_BYPASS_TYPECHECKER = '1',
  },
  filetypes = { "ruby", "eruby" },
  root_markers = { "Gemfile", ".ruby-version", ".mise.toml", ".git" },
  init_options = {
    formatter = 'auto',
    linters = { 'rubocop' },
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },
  },
}

