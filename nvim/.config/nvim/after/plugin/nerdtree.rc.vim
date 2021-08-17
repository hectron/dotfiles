if !exists("g:loaded_nerd_tree")
  finish
endif

map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nf :NERDTreeFind<CR>

" Ignore these kinds of files in NERDTree
let NERDTreeIgnore = ['\.pyc$'] " can be comma-delimited

" Close NERDTree if it's the last thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
