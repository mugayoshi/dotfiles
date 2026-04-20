return {
  cmd = { "pyright-langserver", "--stdio" },
  root_dir = function(fname)
    return vim.fs.root(fname, { "pyproject.toml", "pyrightconfig.json", ".git" })
  end,
  -- uv creates a .venv at the project root; point pyright to it so imports resolve correctly
  on_init = function(client)
    if not client.root_dir then return end
    local venv = client.root_dir .. "/.venv/bin/python"
    if vim.fn.filereadable(venv) == 1 then
      client.config.settings.python.pythonPath = venv
      client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
    end
  end,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
      },
    },
  },
}
