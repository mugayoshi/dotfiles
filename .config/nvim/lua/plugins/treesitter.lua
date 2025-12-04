return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()

      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "astro",
          "svelte",
          "javascript",
          "typescript",
          "html",
          "css",
          "lua",
          "go",
          "python"
        },
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
        },
      })
    end
  }
}
