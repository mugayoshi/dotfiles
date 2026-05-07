return {
  filetypes = { "python" },
  cmd = { "pyright-langserver", "--stdio" },
  -- Use root_markers instead of a root_dir function
  root_markers = { "pyproject.toml", "pyrightconfig.json", ".git" },
  -- uv creates a .venv at the project root; point pyright to it so imports resolve correctly
  on_init = function(client)
    -- Ensure client.root_dir is a string before concatenating
    if not client.root_dir or type(client.root_dir) ~= "string" then return end
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
