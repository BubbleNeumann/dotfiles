vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    vim.cmd [[packadd packer.nvim]]
end
-- stylua: ignore start
require('packer').startup(function(use) --{{{
    use 'wbthomason/packer.nvim'                                                    -- Package manager
    use 'lewis6991/impatient.nvim'                                                  -- Speed up loading Lua modules
    use 'kyazdani42/nvim-tree.lua'                                                  -- Tree view for projects
    use 'tjdevries/colorbuddy.nvim'                                                 -- Gruvbuddy dependency
    use 'tjdevries/gruvbuddy.nvim'                                                  -- Colorsheme
    use 'tjdevries/express_line.nvim'                                               -- Statusline
    use 'kyazdani42/nvim-web-devicons'                                              -- Icons
    use 'tpope/vim-fugitive'                                                        -- Git commands in nvim
    use 'tpope/vim-rhubarb'                                                         -- Fugitive-companion to interact with github
    use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }       -- Add git related info in the signs columns and popups
    use 'numToStr/Comment.nvim'                                                     -- "gc" to comment visual regions/lines
    use 'nvim-treesitter/nvim-treesitter'                                           -- Highlight, edit, and navigate code
    use 'neovim/nvim-lspconfig'                                                     -- Collection of configurations for built-in LSP client
    use 'williamboman/nvim-lsp-installer'                                           -- Automatically install language servers to stdpath
    use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp' } }               -- Autocompletion
    use { 'L3MON4D3/LuaSnip', requires = { 'saadparwaiz1/cmp_luasnip' } }           -- Snippet Engine and Snippet Expansion
    use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } } -- Fuzzy Finder (files, lsp, etc)
    use 'simrat39/rust-tools.nvim'
    use 'lukas-reineke/indent-blankline.nvim'                                       -- Indentation
    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
    use 'puremourning/vimspector'
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable "make" == 1 }
    use 'rust-lang/rust-analyzer'
    use 'ThePrimeagen/harpoon'
    -- todo highlighting
    use {
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup ({
            signs = false
        })
        end
    }
    if is_bootstrap then
        require('packer').sync()
    end
end)
-- }}}
-- stylua: ignore end


--[[======================= OPTIONS =========================]]
-- {{{
local o = vim.opt

local opts = { noremap = true, silent = true }
local km = vim.keymap.set
local keymap = vim.api.nvim_set_keymap

o.clipboard = "unnamedplus"
o.mouse = 'a'
o.termguicolors = true
o.foldmethod = 'indent'
o.updatetime = 50

-- ui
o.number = true
o.relativenumber = true
o.numberwidth = 4

-- cursorline highlighting control
-- only have it on in the active buffer
o.cursorline = true
local group = vim.api.nvim_create_augroup("CursorLineControl", { clear = true })
local set_cursorline = function(event, value, pattern)
  vim.api.nvim_create_autocmd(event, {
    group = group,
    pattern = pattern,
    callback = function()
      vim.opt_local.cursorline = value
    end,
  })
end
set_cursorline("WinLeave", false)
set_cursorline("WinEnter", true)
set_cursorline("FileType", false, "TelescopePrompt")

o.listchars = {eol = '↲', tab = '»·', nbsp ='␣', extends = '…', trail = '·', precedes = '<,extends:>'}
o.list = true
o.hidden = true
o.fillchars = { eob = '~' }

o.scrolloff = 15 -- Make it so there are always 15 lines below the cursor

-- Show matching brackets when text indicator is over them
o.showmatch = true

-- tabs
o.expandtab = true
-- o.smarttab = true
o.autoindent = true
o.cindent = true
o.wrap = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4

o.breakindent = true
o.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
o.linebreak = true

o.formatoptions = o.formatoptions
  - "a" -- Auto formatting is BAD
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

-- o.joinspaces = true

o.undofile = true

-- on startup restore folds and cursor position
vim.cmd [[
    augroup rementer_folds
        autocmd!
        au BufWinLeave ?* mkview 1
        au BufWinEnter ?* silent! loadview 1
    augroup END
]]

-- highlight extra whitespaces
vim.cmd [[
    augroup highlight_extra_whitespaces
        highlight ExtraWhitespace ctermbg=red guibg=red
        match ExtraWhitespace /\s\+$/
        au BufWinEnter * match ExtraWhitespace /\s\+$/
        au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
        au InsertLeave * match ExtraWhitespace /\s\+$/
        au BufWinLeave * call clearmatches()
    augroup END
]]

-- transparent bg
vim.cmd [[
    augroup user_colors
    autocmd!
    autocmd ColorScheme * highlight Normal ctermbg=NONE guibg=NONE
    augroup END
]]

--}}} [[======================= KEYMAPS =========================]]

-- {{{
keymap('i', 'jk', '<ESC>', opts)
-- keymap('n', '<Space>f', '<cmd>lua
-- require"telescope.builtin".find_files(require("telescope.themes").get_dropdown(
-- { previewer = false }))<cr>', opts)
keymap('n', '<Space>f', '<cmd>lua require"telescope.builtin".find_files()<cr>', opts)
keymap('n', '<Space>/', '<cmd>lua require"telescope.builtin".live_grep{ search_dirs={"%:p"} }<cr>', opts) -- search current fileA
keymap('n', '<C-b>', '<cmd>NvimTreeToggle<cr>', opts)

keymap('n', 'tt', '<cmd>vnew<cr><cmd>term<cr><C-w>ri', opts) -- open terminal emulator

-- local bufnr = vim.api.nvim_get_current_buf()
-- local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
-- if ft == "rust" then
    -- keymap('n', '<space-t>', '<C-w>licargo test<cr><C-\\><C-n>', opts) -- run rust test
    -- keymap('n', '<space-r>', '<C-w>licargo run<cr><C-\\><C-n>', opts) -- run rust
-- end

-- keymap('n', '<C-w>', '<C-leader><C-n>', opts)
keymap('n', 'gw', '<C-w>w', opts) -- switch panes
keymap('n', '<C-leader>', '<C-leader><C-n>', opts) -- quit terminal insert mode
-- <space>gw => grep_string <space>f/ => grep_last_search
keymap('n', 'z', 'za', opts)
-- keymap('n', 'tb', '<cmd>TagbarToggle<cr>', opts)
-- keymap('n', '<C-c>', 'y:new ~/.vimbuffer<CR>VGp:x<CR> \\| :!cat ~/.vimbuffer \\| clip.exe <CR>', opts)

-- harpoon
-- https://github.com/ThePrimeagen/.dotfiles/blob/master/nvim/.config/nvim/after/plugin/keymap/harpoon.lua
keymap('n', '<Space>a', '<cmd>lua require("harpoon.mark").add_file()<cr>', opts)
keymap('n', '<C-e>', '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', opts)
keymap('n', '<Space>h', '<cmd>lua require("harpoon.ui").nav_file(1)<cr>', opts)
keymap('n', '<Space>t', '<cmd>lua require("harpoon.ui").nav_file(2)<cr>', opts)
keymap('n', '<Space>n', '<cmd>lua require("harpoon.ui").nav_file(3)<cr>', opts)
keymap('n', '<Space>s', '<cmd>lua require("harpoon.ui").nav_file(4)<cr>', opts)

-- disable arrows
keymap('n', '<Up>', '' , opts)
keymap('n', '<Down>', '', opts)
keymap('n', '<Left>', '', opts)
keymap('n', '<Right>', '', opts)

-- replace
keymap('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)

-- }}}

--[[======================= PLUGINS =========================]]
-- {{{
-- speed up loading Lua modules
require('impatient')

--set colorscheme
vim.cmd 'lua require("colorbuddy").colorscheme("gruvbuddy")'

-- tree view for projects stucture
require('nvim-tree').setup({
    view = {
        side ='left',
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

require("todo-comments").setup ({
    signs = false
})

require('Comment').setup()

o.termguicolors = true
vim.cmd [[highlight IndentBlanklineIndent guifg=#434956 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar guifg =#7d879b gui=nocombine]]
require('indent_blankline').setup {
    filetype = {'rust', 'lua', 'python'},
    indent_show_first_indent_level = false,
    max_indent_increase = 1,
    show_trailing_blankline_indent = false,
    indent_blankline_use_treesitter = true,
    indent_blankline_use_treesitter_scope = true,
    show_current_context = true,
    strict_tabs = true,
    char_highlight_list = { 'IndentBlanklineIndent', }
}

-- GIT
-- require('neogit').setup()

-- statusline
local extensions = require('el.extensions')
local subscribe = require('el.subscribe')
local builtin = require('el.builtin')
local sections = require "el.sections"
local generator = function(_window, buffer)
    local segments = {}

    -- mode
    table.insert(segments, { extensions.gen_mode { format_string = " %s " }, required = true })

    -- git branch
    table.insert(segments,
    subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
        local branch = extensions.git_branch(window, buffer)
        if branch then
            return " " .. " -o- " .. branch
        end
    end
    ))

    -- separator
    table.insert(segments, { sections.split, required = true } )

    -- file name
    table.insert(segments, '%f')

    -- modified flag
    table.insert(segments, { sections.collapse_builtin { { " " }, { builtin.modified_flag } } } )

    table.insert(segments, { sections.split, required = true } )

    -- current line and column
    table.insert(segments, { "  [", builtin.line_with_width(1), ":", builtin.column_with_width(1), "]" })
    table.insert(segments, sections.collapse_builtin { "[", builtin.help_list, builtin.readonly_list, "]" })
    table.insert(segments, builtin.filetype)

   return segments
end

require('el').setup({generator = generator})
-- }}}

--[[====================== TREESITTER =======================]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'lua', 'cpp', 'rust', 'c_sharp', 'python' },

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            -- TODO: I'm not sure for this one.
            scope_incremental = '<c-s>',
            node_decremental = '<c-backspace>',
        },
  },
  textobjects = {
    select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
        },
    },
    move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
        },
        goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
        },
        goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
        },
        goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
        },
    },
    swap = {
        enable = true,
        swap_next = {
            ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
            ['<leader>A'] = '@parameter.inner',
        },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

--[[========================= LSP ===========================]]
-- {{{
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('gr', require('telescope.builtin').lsp_references)
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', vim.lsp.buf.format or vim.lsp.buf.formatting, { desc = 'Format current buffer with LSP' })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'sumneko_lua' }

-- Ensure the servers above are installed
require('nvim-lsp-installer').setup {
  ensure_installed = servers,
}

for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
-- }}}

--[[========================= LUA ===========================]]

-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require('lspconfig').sumneko_lua.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
        },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false, },
    },
  },
}

--[[======================== PYTHON =========================]]

require('lspconfig')['pyright'].setup{
    on_attach = on_attach,
}

--[[========================= RUST ==========================]]
--
-- require('lspconfig')['rust_analyzer'].setup{
--     on_attach = on_attach,
--     -- Server-specific settings...
--     settings = {
--       ["rust-analyzer"] = {}
--     }
-- }

local opts = {
  tools = { -- rust-tools options

    -- how to execute terminal commands
    -- options right now: termopen / quickfix
    executor = require("rust-tools/executors").termopen,

    -- callback to execute once rust-analyzer is done initializing the workspace
    -- The callback receives one parameter indicating the `health` of the server: "ok" | "warning" | "error"
    on_initialized = nil,

    -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
    reload_workspace_from_cargo_toml = true,

    -- These apply to the default RustSetInlayHints command
    inlay_hints = {
      -- automatically set inlay hints (type hints)
      -- default: true
      auto = true,

      -- Only show inlay hints for the current line
      only_current_line = false,

      -- whether to show parameter hints with the inlay hints or not
      -- default: true
      show_parameter_hints = true,

      -- prefix for parameter hints
      -- default: "<-"
      parameter_hints_prefix = "<- ",

      -- prefix for all the other hints (type, chaining)
      -- default: "=>"
      other_hints_prefix = "=> ",

      -- whether to align to the lenght of the longest line in the file
      max_len_align = false,

      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,

      -- whether to align to the extreme right or not
      right_align = false,

      -- padding from the right if right_align is true
      right_align_padding = 7,

      -- The color of the hints
      highlight = "Comment",
    },

    -- options same as lsp hover / vim.lsp.util.open_floating_preview()
    hover_actions = {

      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },

      -- whether the hover action window gets automatically focused
      -- default: false
      auto_focus = false,
    },

    -- settings for showing the crate graph based on graphviz and the dot
    -- command
    crate_graph = {
      -- Backend used for displaying the graph
      -- see: https://graphviz.org/docs/outputs/
      -- default: x11
      backend = "x11",
      -- where to store the output, nil for no output stored (relative
      -- path from pwd)
      -- default: nil
      output = nil,
      -- true for all crates.io and external crates, false only the local
      -- crates
      -- default: true
      full = true,

      -- List of backends found on: https://graphviz.org/docs/outputs/
      -- Is used for input validation and autocompletion
      -- Last updated: 2021-08-26
      enabled_graphviz_backends = {
        "bmp",
        "cgimage",
        "canon",
        "dot",
        "gv",
        "xdot",
        "xdot1.2",
        "xdot1.4",
        "eps",
        "exr",
        "fig",
        "gd",
        "gd2",
        "gif",
        "gtk",
        "ico",
        "cmap",
        "ismap",
        "imap",
        "cmapx",
        "imap_np",
        "cmapx_np",
        "jpg",
        "jpeg",
        "jpe",
        "jp2",
        "json",
        "json0",
        "dot_json",
        "xdot_json",
        "pdf",
        "pic",
        "pct",
        "pict",
        "plain",
        "plain-ext",
        "png",
        "pov",
        "ps",
        "ps2",
        "psd",
        "sgi",
        "svg",
        "svgz",
        "tga",
        "tiff",
        "tif",
        "tk",
        "vml",
        "vmlz",
        "wbmp",
        "webp",
        "xlib",
        "x11",
      },
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    -- standalone file support
    -- setting it to false may improve startup time
    standalone = true,
  }, -- rust-analyer options

  -- debugging stuff
  dap = {
    adapter = {
      type = "executable",
      command = "lldb",
      name = "lldb",
    },
  },
}

require('rust-tools').setup(opts)

--[[======================= LUASNIP =========================]]
--{{{
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local fmt = require("luasnip.extras.fmt").fmt
local i = luasnip.insert_node

-- rust snippets
luasnip.add_snippets("rust", {
    luasnip.s (
        "tmod",
        fmt(
          [[
          #[cfg(test)]
          mod test {{
              use super::*;
              {}
          }}
        ]],
            i(0)
        )
    ),
    luasnip.s (
        "tfn",
        fmt (
        [[
        #[test]
        fn test_{}() {{
            {}
        }}
        ]],
            { i(1), i(0) }
        )
    ),
    luasnip.s("eq", fmt("assert_eq!({}, {});{}", { i(1), i(2), i(0) })),
    luasnip.s("ae", fmt("assert_eq!({}, {});{}", { i(1), i(2), i(0) })),
    luasnip.s("pd", fmt("println!({});", i(0))),
    luasnip.s("{", fmt([[
        {{
            {}
        }}]], i(0) )),
})
-- }}}
-- {{{
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
  },
}
-- }}}
--
