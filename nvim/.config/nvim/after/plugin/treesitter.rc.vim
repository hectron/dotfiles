if !exists("g:loaded_nvim_treesitter")
  finish
endif

lua <<EOF
require('nvim-treesitter.configs').setup{
  ensure_installed = {
    "bash",
    "dockerfile",
    "go",
    "hcl",
    "javascript",
    "json",
    "lua",
    "make",
    "python",
    "ruby",
    "yaml",
    "toml",
    "tsx",
    "typescript",
    "vim",
  }, -- this is available in the list of official parsers
  ignore_install = {}, -- list of parsers to ignore installing
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  incremental_selection = {
    enable = true
  },
  textobjects = {
    enable = true
  },
}
EOF
