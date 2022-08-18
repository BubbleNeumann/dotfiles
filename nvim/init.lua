local g = vim.g
local o = vim.o

-- keybindings
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

keymap('i', 'jk', '<ESC>', opts)
keymap('n', 'ff', '<cmd>lua require"telescope.builtin".find_files(require("telescope.themes").get_dropdown( { previewer = false }))<cr>', opts)
keymap('n', 'fg', '<cmd>Telescope live_grep<cr>', opts)
keymap('n', '<C-b>', '<cmd>NvimTreeToggle<cr>', opts)


-- o.termguicolors = true
vim.opt.mouse = 'a'     

-- ui
o.number = true
o.numberwidth = 4
o.cursorline = true
o.scrolloff = 15 -- Make it so there are always 15 lines below the cursor
o.showmatch = true -- Show matching brackets when text indicator is over them

-- tabs
o.expandtab = true
o.smarttab = true
o.autoindent = true
o.tabstop = 4 
o.shiftwidth = 4

-- decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- plugins
require('plugins')

-- speed up loading Lua modules
require('impatient')

--set colorscheme
vim.cmd 'lua require("colorbuddy").colorscheme("gruvbuddy")'

--completion
local cmp = require 'cmp'

cmp.setup {
    mapping = {
        -- ['<C-d>'] = cmp.mapping.scroll_docs(-1),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(1),
        ['<C-e>'] = cmp.mapping.close(),
        ['<c-space>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        },

        -- ['<c-space>'] = cmp.mapping.complete(),
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end

    },
    sources = {
        { name = 'nvim-lsp' },
        { name = 'buffer', keyword_length = 1 },
    },
}

-- tree view for projects stucture
require('nvim-tree').setup({
    view = {
        side ='left',
    },
    filters = {
        dotfiles = true,
    },
    renderer = {
        icons = {
            glyphs = {
                folder = {
                    arrow_closed = '>',
                },
            },
        },
    },
})

require('telescope').load_extension('fzf')

require('Comment').setup({
    toggler = {
        line = 'gl',
        block = 'gb',
    },
    opleader = {
        line = 'glc',
        block = 'gbc',
    },
})

-- GIT
require('neogit').setup()

-- statusline
require('el').setup()
