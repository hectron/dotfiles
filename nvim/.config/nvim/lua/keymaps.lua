vim.keymap.set({ "n", "v", "o" }, "j", "gj")
vim.keymap.set({ "n", "v", "o" }, "k", "gk")
vim.keymap.set("i", "jj", "<Esc>")

local empty_string = " "
vim.g.mapleader = empty_string
vim.g.localmapleader = empty_string
