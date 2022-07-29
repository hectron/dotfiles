local exists, nvim_tree = pcall(require, "nvim-tree")

if not exists then
  return
end

nvim_tree.setup({
  view = {
    adaptive_size = true,
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
})

local map = vim.api.nvim_set_keymap
map('n', '<LocalLeader>nt', ':NvimTreeToggle<CR>', {})
map('n', '<LocalLeader>nf', ':NvimTreeFindFile<CR>', {})
