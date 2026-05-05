-- install with: gem install ruby-lsp
return {
  cmd = { "mise", "exec", "--", "ruby-lsp" },
  filetypes = { "ruby", "eruby" },
  root_markers = { "Gemfile", ".ruby-version", ".mise.toml", ".git" },
  init_options = {
    formatter = "auto",
    linters = { "rubocop" },
  },
}
