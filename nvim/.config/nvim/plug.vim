let g:plug_home = stdpath("data") . "/plugged"

call plug#begin()
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary' " Easily comment
Plug 'tpope/vim-fugitive'   " Git blame, diff, browse, etc
Plug 'tpope/vim-rhubarb' " View github commit using :GBrowse
Plug 'tpope/vim-endwise'

Plug 'benmills/vimux'
Plug 'vim-test/vim-test' " Run tests in conjuction with vimux

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

if has('nvim-0.5')
  Plug 'neovim/nvim-lspconfig'
  Plug 'gfanto/fzf-lsp.nvim'
  Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
endif

if filereadable(expand("~/.vimrc.plugins.local"))
  source ~/.vimrc.plugins.local
endif

call plug#end()