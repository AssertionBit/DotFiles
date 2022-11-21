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
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
  signs = {
    add          = { hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
    change       = { hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    untracked    = { hl = 'GitSignsAdd'   , text = '┆', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
})
    end
  }
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
  use {
    'nvim-treesitter/nvim-treesitter',
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
