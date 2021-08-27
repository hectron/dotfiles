if !exists("g:loaded_nvim_treesitter")
  finish
endif

lua <<EOF
require('nvim-treesitter.configs').setup{
  ensure_installed = {
    "dockerfile",
    "go",
    "ruby",
    "yaml",
    "json",
    "toml",
  }, -- this is available in the list of official parsers
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
