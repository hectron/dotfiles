map j gj
map k gk

" normal mode mappings
nnoremap <Leader>ev :e $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

" insert mode mappings
inoremap jj <Esc>

autocmd FileType ruby runtime ruby_mappings.vim
