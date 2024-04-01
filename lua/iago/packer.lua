vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use "rebelot/kanagawa.nvim"
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use('nvim-treesitter/playground')
  use "nvim-lua/plenary.nvim"
  use {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    requires = { { "nvim-lua/plenary.nvim" } }
  }
  use 'ThePrimeagen/vim-be-good'
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    requires = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'L3MON4D3/LuaSnip' },
    }
  }
  use 'github/copilot.vim'
  use {
        'adalessa/laravel.nvim',
        requires = {
            'nvim-telescope/telescope.nvim',
            'tpope/vim-dotenv',
            'MunifTanjim/nui.nvim',
            'nvimtools/none-ls.nvim',
        },
        cmd = { 'Sail', 'Artisan', 'Composer', 'Npm', 'Yarn', 'Laravel' },
        -- keys = {
        --     { '<leader>la', ':Laravel artisan<CR>' },
        --     { '<leader>lr', ':Laravel routes<CR>' },
        --     { '<leader>lm', ':Laravel related<CR>' },
        -- },
        -- event = { 'VeryLazy' },
        config = function()
            -- Your plugin-specific configuration can go here
            -- For example:
            -- vim.g.laravel_config_variable = 'value'
        end,
    }
end)
