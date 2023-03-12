local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[ packadd packer.nvim ]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Global configs
  use 'lewis6991/gitsigns.nvim'
  use 'f-person/git-blame.nvim' 
  use {
    'simrat39/symbols-outline.nvim',
    config = function()
      require("symbols-outline").setup()
    end
  }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'nanotee/sqls.nvim'
  use 'AckslD/swenv.nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'roxma/nvim-yarp'
  use 'landaire/deoplete-d'
  use 'ncm2/ncm2-path'
  use 'ncm2/ncm2-bufword'
  use 'ncm2/ncm2-d'
  use 'nvim-treesitter/nvim-treesitter'
  use {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end
  }
  use 'ms-jpq/coq_nvim'

  -- Tweeks
  use 'pocco81/auto-save.nvim'
  use 'filipdutescu/renamer.nvim'
  use 'gpanders/editorconfig.nvim'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }


  -- UI
  use 'nvim-lualine/lualine.nvim'
  use 'sainnhe/gruvbox-material'
  use 'kyazdani42/nvim-web-devicons'
  use 'ThePrimeagen/harpoon'
  use 'nvim-telescope/telescope.nvim'
  use 'folke/noice.nvim' -- Not completable with tree-sitter
  use 'MunifTanjim/nui.nvim'
  use 'rcarriga/nvim-notify'
  use "smiteshp/nvim-navic"
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end
  }


  use {
    "utilyre/barbecue.nvim",
    config = function ()
      require("barbecue").setup()
    end
  }
  use {
  "zbirenbaum/neodim",
  event = "LspAttach",
  config = function ()
    require("neodim").setup({
        alpha = 0.25,
        blend_color = "#000000",
        update_in_insert = {
          enable = true,
          delay = 100,
        },
        hide = {
          virtual_text = true,
          signs = true,
          underline = true,
        }
      })
    end
  }

  -- Utils
  use 'nvim-lua/plenary.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
