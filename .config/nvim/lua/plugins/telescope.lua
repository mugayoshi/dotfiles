return {
  {
    "nvim-telescope/telescope.nvim",
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
          preview = {
            treesitter = false,
          },
          mappings = {
              i = {
                  ["<esc>"] = actions.close,
              },
          },
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              preview_cutoff = 0,
            },
          },
        },
        pickers = {
          find_files = {
            -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
          },
          live_grep = {
            vimgrep_arguments = {
              "rg",
              "--color=never",
              "--no-heading",
              "--with-filename",
              "--line-number",
              "--column",
              "--smart-case",
              "--hidden",
              "--glob",
              "!**/.git/*",
            },
          }
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
