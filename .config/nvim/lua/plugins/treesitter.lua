return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    opts = {
      ensure_installed = {
        "astro",
        "svelte",
        "javascript",
        "typescript",
        "html",
        "css",
        "go",
        "python"
      },
      sync_install = false,
      auto_install = false,
      highlight = {
        enable = true,
      },
    }
  }
}
