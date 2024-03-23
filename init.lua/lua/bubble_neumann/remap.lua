local km = vim.keymap.set

vim.g.mapleader = " "
km("n", "<leader>pv", vim.cmd.Ex)

km("i", "jk", '<Esc>')
km("n", "<leader>w", '<cmd>w<cr>')
km("n", "<leader>q", '<cmd>q<cr>')
km("n", "<leader>c", '<cmd>q<cr>')

km("n", ";h", "<C-w>h")
km("n", ";l", "<C-w>l")

km("v", "J", ":m '>+1<CR>gv=gv")
km("v", "K", ":m '<-2<CR>gv=gv")

-- harpoon
-- https://github.com/ThePrimeagen/.dotfiles/blob/master/nvim/.config/nvim/after/plugin/keymap/harpoon.lua
km('n', '<C-a>', '<cmd>lua require("harpoon.mark").add_file()<cr>', opts)
km('n', '<leader>h', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', opts)
km('n', '<leader>a', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', opts)
km('n', '<leader>s', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', opts)
km('n', '<leader>d', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', opts)
km('n', '<leader>f', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', opts)
