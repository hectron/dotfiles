" Restore vim-diff shortcuts
silent! unmap ]c

map <LocalLeader>rd Orequire "pry"; binding.pry<ESC>

" Search for tag
nmap <silent> <LocalLeader>] :Tags '<C-R><C-W> <CR>
