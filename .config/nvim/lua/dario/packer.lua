return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    -- Colorschemes
    use 'morhetz/gruvbox'
    use 'joshdick/onedark.vim'
    use 'rose-pine/neovim'
    use 'rebelot/kanagawa.nvim'
    use 'vim-scripts/reloaded.vim'
    use 'sainnhe/everforest'
    use 'sainnhe/gruvbox-material'
    -- Plugins
    use 'xiyaowong/nvim-transparent'
    use 'windwp/nvim-autopairs'
    --use 'vim-airline/vim-airline'
    use 'ap/vim-css-color'
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }
    use 'Yggdroot/indentLine'
    use 'ryanoasis/vim-devicons'
    use 'mfussenegger/nvim-jdtls'
    use 'tpope/vim-fugitive'
    use 'preservim/nerdtree'
    use 'mfussenegger/nvim-dap'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-lua/plenary.nvim'
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.1',
    -- or                            , branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }
    -- LSP Support
    use 'neovim/nvim-lspconfig'             -- Required
    use 'williamboman/mason.nvim'           -- Optional
    use 'williamboman/mason-lspconfig.nvim' -- Optional

    -- Autocompletion Engine
    use 'hrsh7th/nvim-cmp'         -- Required
    use 'hrsh7th/cmp-nvim-lsp'     -- Required
    use 'hrsh7th/cmp-buffer'       -- Optional
    use 'hrsh7th/cmp-path'         -- Optional
    use 'saadparwaiz1/cmp_luasnip' -- Optional
    use 'hrsh7th/cmp-nvim-lua'     -- Optional

    --  Snippets
    use 'L3MON4D3/LuaSnip'             -- Required
    use 'rafamadriz/friendly-snippets' -- Optional
    -- Dashboard
    use {
  'glepnir/dashboard-nvim',
  event = 'VimEnter',
  config = function()
	require('dashboard').setup {
	      theme = 'doom',
	  config = {
	  header = {
	      [[]],
	      [[]],
	      [[]],
	      [[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
	      [[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
	      [[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
	      [[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
	      [[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
	      [[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
	      [[]],
	      [[]],
	      [[]],
	  },
	  center = {
	    {
	      icon = '󰭎 ',
	      desc = 'Search Project',
	      key = 'f',
	      action = 'Telescope find_files'
	    },
	    {
	      icon = ' ',
	      desc = 'Search Notes',
	      key = 'n',
	      action = 'cd ~/Documents/Notas | Telescope find_files'
	    },
	    {
	      icon = ' ',
	      desc = 'Search Config',
	      key = 'v',
	      action = 'cd ~/.config/nvim/lua | Telescope find_files'
	    },
	    {
	      icon = '⚙ ',
	      desc = 'Search Dotfiles',
	      key = 'd',
	      action = 'cd ~/.config | Telescope find_files'
	    },
	    {
	      icon = '🎓 ',
	      desc = 'Search University Folder',
	      key = 'u',
	      action = 'cd ~/Universidade | Telescope find_files'
	    },
	    {
	      icon = ' ',
	      desc = 'Sync Packer',
	      key = 's',
	      action = 'PackerSync'
	    },
	  },
	  footer = {}  --your footer
	}
	  }
  end,
  requires = {'nvim-tree/nvim-web-devicons'},
}
end)
