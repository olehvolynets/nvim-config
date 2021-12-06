-- ensure packer is installed
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.vim'
end
-----------------------------



return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'dunstontc/vim-vscode-theme'
    use 'folke/tokyonight.nvim'

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', }
    use { 'rrethy/vim-hexokinase', run = 'make hexokinase' } -- highlight hex colors

    use 'onsails/lspkind-nvim'
    use 'tjdevries/colorbuddy.nvim'

    use 'neovim/nvim-lspconfig'

    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/nvim-cmp'
    use 'saadparwaiz1/cmp_luasnip'

    use 'L3MON4D3/LuaSnip'


    use 'kyazdani42/nvim-tree.lua'
    use 'hoob3rt/lualine.nvim'
    use 'folke/trouble.nvim'
    use {
      "folke/which-key.nvim",
      config = function() require("which-key").setup({}) end
    }

    use { 'junegunn/fzf', run = './install --all' }
    use 'junegunn/fzf.vim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/popup.nvim'},
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        }
    }
    use { 'nvim-telescope/telescope-dap.nvim' }


    use {
        'TimUntersberger/neogit',
        requires = {
            'nvim-lua/plenary.nvim',
            'sindrets/diffview.nvim'
        }
    }
    use { 'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'} }


    use {
      'rcarriga/vim-ultest',
      requires = {'vim-test/vim-test'},
      run = ':UpdateRemotePlugins',
    }
    use 'mfussenegger/nvim-dap'
    -- use 'rcarriga/nvim-dap-ui'


    use { 'tpope/vim-endwise', ft = { 'rb', 'ruby' } }
    use 'szw/vim-maximizer'
    use 'jiangmiao/auto-pairs' -- find lua analogue
    use 'tpope/vim-surround'
    use 'andrewradev/splitjoin.vim'
    use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
    }
    use 'vimwiki/vimwiki'
    use { 'jgdavey/tslime.vim', branch = 'main' }


    -- slow, need alternative
    use 'tpope/vim-dadbod'
    use 'kristijanhusak/vim-dadbod-ui'
end)