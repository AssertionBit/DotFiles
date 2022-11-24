local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
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
  use {
    'nvim-treesitter/nvim-treesitter',
  }
  use {
    '',
    config = function()
      vim.cmd[[ autocmd BufEnter * call ncm2#enable_for_buffer() ]]
      vim.cmd[[ set completeopt=noinsert,menuone,noselect ]]
    end
  }
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

  -- UI
  use 'nvim-lualine/lualine.nvim'
  use 'sainnhe/gruvbox-material'
  use 'kyazdani42/nvim-web-devicons'
  use 'ThePrimeagen/harpoon'
  use {
    -- "m-demare/hlargs.nvim",
    -- config = function()
    --  return 0
     -- require('hlargs').setup {
     --   color = '#ef9062',
    --    highlight = {},
    --    excluded_filetypes = {},
    --    paint_arg_declarations = true,
   --     paint_arg_usages = true,
   --     paint_catch_blocks = {
     --     declarations = false,
    --      usages = false
   --     },
    --    extras = {
    --      named_parameters = false,
    --    },
    --    hl_priority = 10000,
    --    excluded_argnames = {
    --      declarations = {},
    --      usages = {
    --        python = { 'self', 'cls' },
    --        lua = { 'self' },
    --      }
    --    },
   --     performance = {
   --       parse_delay = 1,
   --       slow_parse_delay = 50,
   --       max_iterations = 400,
    --      max_concurrent_partial_parses = 30,
   --       debounce = {
   --         partial_parse = 3,
    --        partial_insert_mode = 100,
    --        total_parse = 700,
    --        slow_parse = 5000
   --       }
    --    }
   --   }
    --  end
  }
  
  -- use 'folke/noice.nvim' -- Not completable with tree-sitter
  use 'MunifTanjim/nui.nvim'
  use 'rcarriga/nvim-notify'
  use "smiteshp/nvim-navic"

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
