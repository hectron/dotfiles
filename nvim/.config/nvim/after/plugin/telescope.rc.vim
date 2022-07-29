if !exists("g:loaded_telescope")
  finish
endif

map <silent> <LocalLeader>ff :Telescope find_files find_command=rg,--files,--iglob,!.git,--hidden<CR>
map <silent> <LocalLeader>fb :Telescope buffers<CR>
map <silent> <LocalLeader>ft :Telescope tags<CR>
map <silent> <LocalLeader>fg :Telescope live_grep<CR>
map <silent> <LocalLeader>gh :Telescope help_tags<cr>
map <silent> <C-p> :Telescope find_files find_command=rg,--files,--iglob,!.git,--hidden<CR>
nnoremap <silent> <Leader>gw :Telescope grep_string<CR>

" git navigation
map <silent> <LocalLeader>gco :Telescope git_commits<cr>
map <silent> <LocalLeader>ggs :Telescope git_status<cr>
map <silent> <LocalLeader>ggc :Telescope git_bcommits<cr>


lua << EOF
local actions = require("telescope.actions")

require("telescope").setup{
  pickers = {
    live_grep = {
      additional_args = function(opts)
        -- show hidden files, respect the .gitignore, and ignore .git dir
        return { "--hidden", "-g", "!.git/" }
      end,
    },
  },
  defaults = {
    mappings = {
      -- when a menu pops up, press q to close in normal mode
      n = {
        ["q"] = actions.close
      }
    }
  }
}

require("telescope").load_extension("fzf")
EOF
