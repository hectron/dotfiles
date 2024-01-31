" if has_key(plugs, 'vimux')
"   map <silent> <LocalLeader>rb :wa<CR>:TestFile<CR>
"   map <silent> <LocalLeader>rf :wa<CR>:TestNearest<CR>
"   map <silent> <LocalLeader>rl :wa<CR>:TestLast<CR>
"   map <silent> <LocalLeader>rx :wa<CR>:VimuxCloseRunner<CR>
"   map <silent> <LocalLeader>ri :wa<CR>:VimuxInspectRunner<CR>
"   map <silent> <LocalLeader>rs :!ruby -c %<CR>
"   map <silent> <LocalLeader>AA   :A<CR>
"   map <silent> <LocalLeader>AV   :AV<CR>
"   map <silent> <LocalLeader>AS   :AS<CR>
" endif

" Restore vim-diff shortcuts
silent! unmap ]c

map <LocalLeader>rd Orequire "pry"; binding.pry<ESC>

" Search for tag
nmap <silent> <LocalLeader>] :Tags '<C-R><C-W> <CR>
