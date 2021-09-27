if !exists("g:loaded_vimux")
  finish
endif

map <silent> <LocalLeader>rb :wa<CR> :TestFile<CR>
map <silent> <LocalLeader>vl :wa<CR> :VimuxRunLastCommand<CR>
map <silent> <LocalLeader>vi :wa<CR> :VimuxInspectRunner<CR>
map <silent> <LocalLeader>vk :wa<CR> :VimuxInterruptRunner<CR>
map <silent> <LocalLeader>vx :wa<CR> :VimuxClosePanes<CR>
map <silent> <LocalLeader>vp :VimuxPromptCommand<CR>
vmap <silent> <LocalLeader>vs "vy :call VimuxRunCommand(@v)<CR>

let g:VimuxUseNearestPane = 1
let test#strategy = "vimux"
