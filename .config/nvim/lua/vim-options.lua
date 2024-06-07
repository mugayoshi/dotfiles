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
-- copy the file path of the currently open file
vim.keymap.set("n", "<leader>fpc", "<cmd>let @+=expand('%:p')<CR>", { noremap = true, silent = true })

