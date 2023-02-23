local km = vim.keymap.set

vim.g.mapleader = " "
km("n", "<leader>pv", vim.cmd.Ex)

km("i", "jk", '<Esc>')
km("n", "<leader>w", '<cmd>w<cr>')
km("n", "<leader>q", '<cmd>q<cr>')
km("n", "<leader>c", '<cmd>q<cr>')

km("v", "J", ":m '>+1<CR>gv=gv")
km("v", "K", ":m '<-2<CR>gv=gv")

