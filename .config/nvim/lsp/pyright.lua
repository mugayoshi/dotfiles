return {
  cmd = { "pyright-langserver", "--stdio" },
	settings = {
		python = {
			-- pythonPath = ".venv/bin/python",
			analysis = {
				typeCheckingMode = "basic",
				autoSearchPaths = true,
				useLibraryCodeForTypes = true,
				diagnosticMode = "openFilesOnly",
			},
		},
	},
}

