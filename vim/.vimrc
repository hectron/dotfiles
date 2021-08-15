" Auto install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" === plugins ===

if filereadable(expand("~/.vimrc.plugins"))
  source ~/.vimrc.plugins
elseif filereadable(expand("~/.vim/vimrc.plugins"))
  source ~/.vim/vimrc.plugins
endif

" === general ===

compiler ruby
syntax on
set hlsearch
set number
set showmatch
set incsearch
set background=dark
set hidden
set backspace=indent,eol,start
set textwidth=0 nosmartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set ruler
set wrap
set dir=/tmp//
set scrolloff=5
set ignorecase
set smartcase
set wildignore+=*.pyc,*.o,*.class,*.lo,.git,vendor/*,node_modules/**,bower_components/**,*/build_gradle/*,*/build_intellij/*,*/build/*,*/cassandra_data/*
set tags+=gems.tags
set mouse=
if !has('nvim')
  set ttymouse=
endif
set backupcopy=yes " Setting backup copy preserves file inodes, which are needed for Docker file mounting
set signcolumn=yes
set complete-=f " Don't use tags for autocomplete
set updatetime=200

set undodir=~/.vim/undodir
set undofile
set undoreload=10000 "maximum number lines to save for undo on a buffer reload
set undolevels=1000 "maximum number of changes that can be undone

set encoding=utf8
set ffs=unix,dos,mac
set clipboard=unnamedplus

if has("statusline")
  " Always show the status line
  set laststatus=2

  " Start the status line
  set statusline=%f\ %m\ %r
  set statusline+=Line:%l/%L[%p%%]
  set statusline+=Col:%v
  set statusline+=Buf:#%n
  set statusline+=[%b][0x%B]
endif

" === Functions ===

function! GitGrepWord()
  cgetexpr system("git grep -n '" . expand("<cword>") . "'")
  cwin
  echo 'Number of matches: ' . len(getqflist())
endfunction

command! -nargs=0 GitGrepWord :call GitGrepWord()

" === Shortcuts ===

map j gj
map k gk
map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>
map <silent> <LocalLeader>ff :Telescope find_files find_command=fd,-IH,-E.git<CR>
map <silent> <leader>fb :Telescope buffers<CR>
map <silent> <leader>ft :Telescope tags<CR>
map <silent> <LocalLeader>rb :wa<CR> :TestFile<CR>
map <silent> <C-p> :Telescope find_files find_command=fd,-IH,-E.git<CR>

" Vimux
map <silent> <LocalLeader>vl :wa<CR> :VimuxRunLastCommand<CR>
map <silent> <LocalLeader>vi :wa<CR> :VimuxInspectRunner<CR>
map <silent> <LocalLeader>vk :wa<CR> :VimuxInterruptRunner<CR>
map <silent> <LocalLeader>vx :wa<CR> :VimuxClosePanes<CR>
map <silent> <LocalLeader>vp :VimuxPromptCommand<CR>

" normal mode mappings
nnoremap <Leader>ev :e $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gw :Gbrowse-<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <silent> <Leader>gw :GitGrepWord<CR>

" insert mode mappings
inoremap jj <Esc>

let g:VimuxUseNearestPane = 1
let test#strategy = "vimux"

" Ruby-specific vimux bindings (@see dotfiles for how to setup)
autocmd FileType ruby runtime ruby_mappings.vim
" Apply automatic 120 width of characters
autocmd BufRead,BufNewFile *.md setlocal textwidth=120
" Close NERDTree if it's the last thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Ignore these kinds of files in NERDTree
let NERDTreeIgnore = ['\.pyc$'] " can be comma-delimited

" Ignore these kinds of files in CtrlP, if in a .gitignore file
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

let wiki = {}
let wiki.path = "~/me/wiki"
let wiki.auto_toc = 1
let wiki.auto_tags = 1
let wiki.auto_diary_index = 1
let wiki.auto_generate_links = 1
let wiki.auto_generate_tags = 1
let wiki_list = [wiki]

" til wiki configuration
"   make sure the repository is cloned, and the env var is set
if $TIL_DIR != ""
  let til_wiki = {}
  let til_wiki.path = $TIL_DIR . "/content"
  let til_wiki.syntax = "markdown"
  let til_wiki.ext = ".md"

  let til_wiki.diary_rel_path = "til/"

  let til_wiki.auto_diary_index = 1
  let til_wiki.auto_generate_links = 1
  let til_wiki.auto_generate_tags = 1
  let til_wiki.auto_toc = 1 
  let wiki_list = [til_wiki, wiki]
endif

let g:vimwiki_list = wiki_list
let g:vimwiki_listsyms = "✗○◐●✓"

colorscheme spaceduck

if has('nvim-0.5')
  lua << EOF
  local status, nvim_lsp = pcall(require, 'lspconfig')

  if status then
    local on_attach = function(client, bufnr)
      local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

      buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      local opts = { noremap = true, silent = true }

      -- Inspired by https://github.com/neovim/nvim-lspconfig/#keybindings-and-completion,
      -- but with <leader> instead of <space>

      -- Navigation
      buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
      buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)

      -- Information
      buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
      buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      buf_set_keymap('n', '<Leader>ds', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)

      -- Diagnostics
      buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
      buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
      buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
      buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)

      -- Refactoring
      buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

      -- Workspaces
      buf_set_keymap('n', '<Leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<Leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
      buf_set_keymap('n', '<Leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
      buf_set_keymap('n', '<Leader>ws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
    end

    nvim_lsp.solargraph.setup{
      on_attach = on_attach,
      settings = {
        filetypes = { "ruby", "rake" }
      }
    }
  end

  require('nvim-treesitter.configs').setup{
    ensure_installed = {"ruby"}, -- this is available in the list of official parsers
    ignore_install = {}, -- list of parsers to ignore installing
    highlight = {
      enable = true
    },
    incremental_selection = {
      enable = true
    },
    textobjects = {
      enable = true
    },
  }
EOF
endif
