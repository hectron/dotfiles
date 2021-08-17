if !exists("g:loaded_fugitive")
  finish
endif

nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gw :Gbrowse-<CR>
nnoremap <Leader>gr :Gread<CR>

