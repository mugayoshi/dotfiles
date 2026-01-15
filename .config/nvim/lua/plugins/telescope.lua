return {
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.5",
     dependencies = { "nvim-lua/plenary.nvim" },
     config = function()
       local builtin = require("telescope.builtin")
       vim.keymap.set("n", "<C-p>", builtin.find_files, {})
       vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
       vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
     end
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          mappings = {
              i = {
                  ["<esc>"] = actions.close,
              },
          },
        },
        pickers = {
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
          }
        }
      })
      require("telescope").load_extension("ui-select")
    end
  }
}
