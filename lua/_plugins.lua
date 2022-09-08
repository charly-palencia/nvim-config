local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
--[[ vim.cmd [[ ]]
--[[   augroup packer_user_config ]]
--[[     autocmd! ]]
--[[     autocmd BufWritePost plugins.lua source <afile> | PackerSync ]]
--[[   augroup end ]]
--[[ ]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "kyazdani42/nvim-web-devicons"
  use "kyazdani42/nvim-tree.lua"

  use "akinsho/toggleterm.nvim"

  use 'feline-nvim/feline.nvim'

  use "lewis6991/impatient.nvim"
  use "lukas-reineke/indent-blankline.nvim"
  use "goolord/alpha-nvim"
  use "folke/which-key.nvim"

  use "norcalli/nvim-colorizer.lua"
  use "windwp/nvim-spectre"
  use "karb94/neoscroll.nvim"
  use "Mephistophiles/surround.nvim"
  use "rcarriga/nvim-notify"
  use "tversteeg/registers.nvim"
  use { "christianchiarulli/nvim-gps", branch = "text_hl" }
  use { "michaelb/sniprun", run = "bash ./install.sh" }
  -- use {
  --   "christianchiarulli/JABS.nvim",
  --   requires = { "kyazdani42/nvim-web-devicons" }, --optional
  -- }


  -- Colorschemes
  use "olimorris/onedarkpro.nvim"
  use 'catppuccin/nvim'
  use "ellisonleao/gruvbox.nvim"
  use "themercorp/themer.lua"

  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"
  -- use {
  --   "tzachar/cmp-tabnine",
  --   config = function()
  --     local tabnine = require "cmp_tabnine.config"
  --     tabnine:setup {
  --       max_lines = 1000,
  --       max_num_results = 20,
  --       sort = true,
  --       run_on_every_keystroke = true,
  --       snippet_placeholder = "..",
  --       ignored_file_types = { -- default is not to ignore
  --         -- uncomment to ignore in lua:
  --         -- lua = true
  --       },
  --     }
  --   end,
  --
  --   run = "./install.sh",
  --   requires = "hrsh7th/nvim-cmp",
  -- }

  -- use 'David-Kunz/cmp-npm' -- doesn't seem to work

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "simrat39/symbols-outline.nvim"
  use "ray-x/lsp_signature.nvim"
  use "b0o/SchemaStore.nvim"
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use "github/copilot.vim"
  use {
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require "user.copilot"
      end, 100)
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    module = "copilot_cmp",
  }
  use "RRethy/vim-illuminate"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-media-files.nvim"
  use { 'axkirillov/easypick.nvim', requires = 'nvim-telescope/telescope.nvim' }
  -- use "nvim-telescope/telescope-ui-select.nvim"
  -- use "nvim-telescope/telescope-file-browser.nvim"

  -- Treesitter
  use "nvim-treesitter/nvim-treesitter"
  use 'nvim-treesitter/nvim-treesitter-context'
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "p00f/nvim-ts-rainbow"
  use { 'christianchiarulli/nvim-ts-rainbow' }
  use "nvim-treesitter/playground"
  use "windwp/nvim-ts-autotag"
  -- use "romgrk/nvim-treesitter-context"

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "f-person/git-blame.nvim"
  use "ruifm/gitlinker.nvim"
  use "mattn/vim-gist"
  use "mattn/webapi-vim"

  -- Test
  use 'vim-test/vim-test'

  -- MISC
  use 'kazhala/close-buffers.nvim'
  use 'alexghergh/nvim-tmux-navigation'

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
