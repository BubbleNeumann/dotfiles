return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    -- speed up loading Lua modules
    use 'lewis6991/impatient.nvim'   

    -- colorschemes
    use 'tjdevries/colorbuddy.nvim'
    use 'tjdevries/gruvbuddy.nvim'

    -- completion
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-nvim-lsp'

    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }

    -- dependency
    use 'nvim-lua/plenary.nvim'

    -- search
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    -- comments
    use 'numToStr/Comment.nvim'

    -- GIT:
   use 'TimUntersberger/neogit'

   -- statusline
   use 'tjdevries/express_line.nvim'

end)
