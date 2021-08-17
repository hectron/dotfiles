if !exists("g:loaded_telescope")
  finish
endif

map <silent> <LocalLeader>ff :Telescope find_files find_command=rg,--files,--iglob,!.git,--hidden<CR>
map <silent> <LocalLeader>fb :Telescope buffers<CR>
map <silent> <LocalLeader>ft :Telescope tags<CR>
map <silent> <LocalLeader>fg :Telescope live_grep<CR>
map <silent> <C-p> :Telescope find_files find_command=rg,--files,--iglob,!.git,--hidden<CR>
nnoremap <silent> <Leader>gw :Telescope g

lua << EOF
local actions = require("telescope.actions")

require("telescope").setup{
  defaults = {
    mappings = {
      -- when a menu pops up, press q to close in normal mode
      n = {
        ["q"] = actions.close
      }
    }
  }
}
EOF
