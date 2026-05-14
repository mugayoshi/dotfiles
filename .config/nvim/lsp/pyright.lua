local function get_pipenv_dir()
  return vim.fn.trim(vim.fn.system("pipenv --venv"))
end

local function get_poetry_dir()
  return vim.fn.trim(vim.fn.system("poetry env info -p"))
end

local function get_python_dir(workspace)
  local poetry_match = vim.fn.glob(vim.fs.joinpath(workspace, "poetry.lock"))
  if poetry_match ~= "" then
    return get_poetry_dir()
  end

  local pipenv_match = vim.fn.glob(vim.fs.joinpath(workspace, "Pipfile.lock"))
  if pipenv_match ~= "" then
    return get_pipenv_dir()
  end

  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(vim.fs.joinpath(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then
      return vim.fs.dirname(match)
    end
  end

  return ""
end

return {
  filetypes = { "python" },
  cmd = { "pyright-langserver", "--stdio" },
  root_markers = { "pyproject.toml", "pyrightconfig.json", ".git" },
  on_init = function(client)
    if not client.root_dir or type(client.root_dir) ~= "string" then return end
    local workspace = client.root_dir

    local venv = get_python_dir(workspace)
    if venv == "" then return end

    local python = vim.fs.joinpath(venv, "bin", "python")
    if vim.fn.filereadable(python) == 1 then
      client.config.settings.python.pythonPath = python
      -- notify is deprecated
      -- client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
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
