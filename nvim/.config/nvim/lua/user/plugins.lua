local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "airblade/vim-gitgutter",
  "tpope/vim-commentary", -- Easily comment
  "tpope/vim-fugitive",   -- Git blame, diff, browse, etc
  "tpope/vim-rhubarb",    -- View github commit using :GBrowse
  "tpope/vim-endwise",
  "benmills/vimux",
  "vim-test/vim-test", -- Run tests in conjuction with vimux

  "pgr0ss/vim-github-url",
  "sheerun/vim-polyglot", -- better syntax highlighting
  "editorconfig/editorconfig-vim",
  "SmiteshP/nvim-navic",
  "glepnir/galaxyline.nvim",
  "glepnir/lspsaga.nvim",

  -- (Optional) Multi-entry selection UI.
  -- { "junegunn/fzf", build = vim.fn["fzf#install"] },

  -- Language plugins
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",
  "vim-ruby/vim-ruby",
  "tpope/vim-rails",
  { "fatih/vim-go",     build = ":GoUpdateBinaries" },
  "leafgarland/typescript-vim",

  -- Icons/Colors
  "ryanoasis/vim-devicons",
  "kyazdani42/nvim-web-devicons",
  'Yazeed1s/minimal.nvim',
  "pineapplegiant/spaceduck",
  "folke/tokyonight.nvim",
  { "rose-pine/neovim", name = "rose-pine" }, -- kinda soho/minimalist
  { "catppuccin/nvim",  name = "catppuccin" },
  "olimorris/onedarkpro.nvim",
  "rebelot/kanagawa.nvim",
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme nordic]])
    end
  },
  "oxfist/night-owl.nvim",

  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  --
  -- TODO Plug "williamboman/nvim-lsp-installer" -- auto-install LSP servers
  --
  "jose-elias-alvarez/null-ls.nvim", -- any missing LSP features can be implemented with other tools

  --Plug("j-hui/fidget.nvim", { tag = "legacy" })
  --Plug "lewis6991/impatient.nvim"
  { "nvim-treesitter/nvim-treesitter",          build = ":TSUpdate" },
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "kyazdani42/nvim-tree.lua",
  --
  -- TODO Plug "stevearc/aerial.nvim"
  --
  "gfanto/fzf-lsp.nvim",
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  "rgroli/other.nvim", -- projectionist/a.vim alternative
  "mfussenegger/nvim-dap",
  "lukas-reineke/indent-blankline.nvim",
  "echasnovski/mini.indentscope", -- complimentary to ^
  "ellisonleao/glow.nvim",

  -- Autocomplete for lsp
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "onsails/lspkind.nvim", -- VScode like icons for cmp
  "nathom/filetype.nvim", -- better detection of filetypes
})
