local installed, lspsaga = pcall(require, "lspsaga")

if not installed or not lspsaga then
  return
end

lspsaga.setup({})

local keymap = vim.keymap.set

-- Actions
keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "[c]ode [a]ction" })

-- Diagnostics
keymap("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "[e]xplain diagnostics" })
keymap("n", "<leader>be", "<cmd>Lspsaga show_buf_diagnostics<CR>", { desc = "[b]uffer [e]xplain diagnostics" })
keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Navigation
keymap("n", "<leader>fr", "<cmd>Lspsaga lsp_finder<CR>", { desc = "[f]ind symbol [r]eference" })
keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { desc = "[o]pen outline" })
keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "[g]o to [d]efinition" })
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "[g]o [p]eek definition" })

-- Terminal
keymap("n", "<leader>tt", "<cmd>Lspsaga term_toggle<CR>", { desc = "[t]erminal [t]oggle" })
keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")
