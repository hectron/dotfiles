local exists, indent_blankline = pcall(require, "ibl")

if not exists then
  return
end

local help_exists, mini_indentscope = pcall(require, "mini.indentscope")

if help_exists then
  mini_indentscope.setup()
end

vim.opt.list = true

indent_blankline.setup {
  exclude = {
    filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
  },
}
