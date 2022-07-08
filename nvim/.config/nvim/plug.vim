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


" (Optional) Multi-entry selection UI.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'vimwiki/vimwiki'

" Language plugins
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'leafgarland/typescript-vim'

" Colors
Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'rose-pine/neovim', { 'as': 'rose-pine' } " kinda soho/minimalist
Plug 'catppuccin/nvim', {'as': 'catppuccin'}
Plug 'olimorris/onedarkpro.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/nvim-lsp-installer'  " auto-install LSP servers

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'gfanto/fzf-lsp.nvim', { 'branch': 'main' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'branch': 'main', 'do': 'make' }

" Autocomplete for lsp
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

if filereadable(expand("~/.vimrc.plugins.local"))
  source ~/.vimrc.plugins.local
endif

call plug#end()
