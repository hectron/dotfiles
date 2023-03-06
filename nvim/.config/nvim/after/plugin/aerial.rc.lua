local installed, aerial = pcall(require, "aerial")

if not installed or not aerial then
  return
end

local config = {
  backends = { "treesitter", "lsp", "markdown" },
  layout = {
    min_width = 28,
  },
  show_guides = true,
  filter_kind = false,
  guides = {
    mid_item = "├ ",
    last_item = "└ ",
    nested_top = "│ ",
    whitespace = "  ",
  },
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<cr>", { buffer = bufnr, desc = "Jump backwards in Aerial" })
    vim.keymap.set("n", "}", "<cmd>AerialNext<cr>", { buffer = bufnr, desc = "Jump forwards in Aerial" })
    -- Jump up the tree with '[[' or ']]'
    vim.keymap.set("n", "[[", "<cmd>AerialPrevUp<cr>", { buffer = bufnr, desc = "Jump up and backwards in Aerial" })
    vim.keymap.set("n", "]]", "<cmd>AerialNextUp<cr>", { buffer = bufnr, desc = "Jump up and forwards in Aerial" })
  end,
}

vim.keymap.set("n", "<leader>at", "<cmd>AerialToggle!<CR>")
aerial.setup(config)
