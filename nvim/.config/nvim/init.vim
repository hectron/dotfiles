syntax on

" Auto install vim-plug
let data_dir = has("nvim") ? stdpath("data") . "/site" : "~/.vim"

if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute "!curl -fLo ".data_dir."/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

compiler ruby
syntax enable
set hlsearch         " highlight all matches from search pattern
set number           " precede line w/it's number
set showmatch        " jump to match (e.g. when a bracket is inserted, jump to the matching one)
set incsearch        " search as the typing is going on
set background=dark
set hidden           " keeps buffers available in the background
set backspace=indent,eol,start " makes backspace work as you'd expect it to
set textwidth=0 nosmartindent tabstop=2 shiftwidth=2 softtabstop=2 expandtab " indent using spaces, use Ctrl+V<Tab> to insert a real tab
set ruler            " show the line number + cursor position
set wrap             " wraps lines in the terminal display. stays in the same line, though
set scrolloff=5      " the number of lines that you will want to keep above+below cursor as you scroll
set ignorecase       " ignores case in a pattern
set smartcase
set wildignore+=*.pyc,*.o,*.class,*.lo,.git,vendor/*,node_modules/**,bower_components/**,*/build_gradle/*,*/build_intellij/*,*/build/*,*/cassandra_data/*
set tags+=gems.tags
set backupcopy=yes " Setting backup copy preserves file inodes, which are needed for Docker file mounting
set signcolumn=yes
set complete-=f " Don't use tags for autocomplete
set updatetime=200
set encoding=utf8
set ffs=unix,dos,mac
set clipboard=unnamedplus
set title

" Always show the status line
set laststatus=2

" Start the status line
set statusline=%f\ %m\ %r
set statusline+=Line:%l/%L[%p%%]
set statusline+=Col:%v
set statusline+=Buf:#%n
set statusline+=[%b][0x%B]

runtime plug.vim " plugins

runtime maps.vim " generic key mappings, custom ones go in after/plugin/

" Apply automatic 120 width of characters
autocmd BufRead,BufNewFile *.md setlocal textwidth=120

colorscheme spaceduck
" spaceduck has a weird highlight where it blends too much with the
" background, so we use an explicitly darker grey to help
hi Visual ctermbg=DarkGrey

set exrc
