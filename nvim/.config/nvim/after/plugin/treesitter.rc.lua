local exists, treesitter_config = pcall(require, "nvim-treesitter.configs")

if not exists then
  return
end

treesitter_config.setup {
  ensure_installed = {
    "bash",
    "c",
    "dockerfile",
    "go",
    "hcl",
    "javascript",
    "json",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "puppet",
    "query",
    "ruby",
    "rust",
    "yaml",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
  },                   -- this is available in the list of official parsers
  ignore_install = {}, -- list of parsers to ignore installing
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
    use_languagetree = true,
  },
  incremental_selection = {
    enable = true
  },
  textobjects = {
    enable = true
  },
}
