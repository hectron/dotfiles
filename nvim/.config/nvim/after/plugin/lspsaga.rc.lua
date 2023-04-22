local installed, lspsaga = pcall(require, "lspsaga")

if not installed or not lspsaga then
  return
end

lspsaga.setup({})

local keymap = vim.keymap.set

-- Diagnostics
keymap("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "[e]xplain diagnostics" })
keymap("n", "<leader>be", "<cmd>Lspsaga show_buf_diagnostics<CR>", { desc = "[b]uffer [e]xplain diagnostics" })
keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Navigation
keymap("n", "<leader>fr", "<cmd>Lspsaga lsp_finder<CR>", { desc = "[f]ind symbol [r]eference" })
keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { desc = "[o]pen outline" })

-- Terminal
keymap("n", "<leader>tt", "<cmd>Lspsaga term_toggle<CR>", { desc = "[t]erminal [t]oggle" })
