vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd('inoremap <C-j> <Esc>')
vim.cmd('inoremap <Esc> <Nop>')
vim.g.mapleader = " "
vim.opt.nu = true
vim.opt.relativenumber = true
vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
-- yank the file path of the currently open file to clipboard
vim.keymap.set("n", "<leader>yfp", "<cmd>let @+=expand('%:p')<CR>", { noremap = true, silent = true })

-- lsp
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)

vim.opt.spelllang = 'en'
vim.opt.spell = true
