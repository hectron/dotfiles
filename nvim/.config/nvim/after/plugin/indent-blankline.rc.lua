local exists, indent_blankline = pcall(require, "indent_blankline")

if not exists then
  return
end

local help_exists, mini_indentscope = pcall(require, "mini.indentscope")

if help_exists then
  mini_indentscope.setup()
end

vim.opt.list = true

indent_blankline.setup {
  char = "|",
  filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
  show_current_context = false,
  show_trailing_blankline_indent = false,
}
