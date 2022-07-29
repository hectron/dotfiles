let g:plug_home = stdpath("data") . "/plugged"

call plug#begin(plug_home)
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary' " Easily comment
Plug 'tpope/vim-fugitive'   " Git blame, diff, browse, etc
Plug 'tpope/vim-rhubarb' " View github commit using :GBrowse
Plug 'tpope/vim-endwise'

Plug 'benmills/vimux'
Plug 'vim-test/vim-test' " Run tests in conjuction with vimux

Plug 'pgr0ss/vim-github-url'
Plug 'sheerun/vim-polyglot' " better syntax highlighting
Plug 'editorconfig/editorconfig-vim'
Plug 'SmiteshP/nvim-navic'
Plug 'glepnir/galaxyline.nvim'

" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'vimwiki/vimwiki'

" Language plugins
Plug 'L3MON4D3/LuaSnip'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'leafgarland/typescript-vim'

" Icons/Colors
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'pineapplegiant/spaceduck'
Plug 'folke/tokyonight.nvim'
Plug 'rose-pine/neovim', { 'as': 'rose-pine' } " kinda soho/minimalist
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'olimorris/onedarkpro.nvim'
Plug 'rebelot/kanagawa.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'  " auto-install LSP servers
Plug 'jose-elias-alvarez/null-ls.nvim'  " any missing LSP features can be implemented with other tools

Plug 'j-hui/fidget.nvim'
Plug 'lewis6991/impatient.nvim'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'gfanto/fzf-lsp.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

" Autocomplete for lsp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

if filereadable(expand("~/.vimrc.plugins.local"))
  source ~/.vimrc.plugins.local
endif

call plug#end()
