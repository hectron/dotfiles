vim.keymap.set({ "n", "v", "o" }, "j", "gj")
vim.keymap.set({ "n", "v", "o" }, "k", "gk")
vim.keymap.set("i", "jj", "<Esc>")

local empty_string = " "
local backslash = "\\"
vim.g.mapleader = empty_string
vim.g.localmapleader = empty_string

vim.keymap.set("n", backslash, "<leader>", { remap = true })
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
