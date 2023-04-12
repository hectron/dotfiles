local installed, other = pcall(require, "other-nvim")

if not installed then
  return
end

other.setup({
  mappings = {
    "rails"
  },
})

vim.api.nvim_set_keymap("n", "<leader>OF", "<cmd>:Other<CR>", { noremap = true, silent = true })
