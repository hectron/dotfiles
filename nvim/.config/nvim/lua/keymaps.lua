vim.keymap.set({ "n", "v", "o" }, "j", "gj")
vim.keymap.set({ "n", "v", "o" }, "k", "gk")

vim.keymap.set("n", "<Leader>ev", "<cmd>e $MYVIMRC<cr>")
vim.keymap.set("n", "<Leader>sv", "<cmd>source $MYVIMRC<cr>")

vim.keymap.set("i", "jj", "<Esc>")

vim.cmd([[autocmd FileType ruby runtime ruby_mappings.vim]])
