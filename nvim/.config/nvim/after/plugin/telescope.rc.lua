local installed, telescope = pcall(require, "telescope")

if not installed then
  return
end

local find_files_cmd = ":Telescope find_files find_command=rg,--files,--iglob,!.git,--hidden<CR>"

vim.api.nvim_set_keymap("", "<C-p>", find_files_cmd, { silent = true })
vim.api.nvim_set_keymap("", "<LocalLeader>ff", find_files_cmd, { silent = true })
vim.api.nvim_set_keymap("", "<LocalLeader>fb", ":Telescope buffers<CR>", { silent = true })
vim.api.nvim_set_keymap("", "<LocalLeader>ft", ":Telescope tags<CR>", { silent = true })
vim.api.nvim_set_keymap("", "<LocalLeader>fg", ":Telescope live_grep<CR>", { silent = true })
vim.api.nvim_set_keymap("", "<LocalLeader>fm", ":Telescope keymaps<CR>", { silent = true })
vim.api.nvim_set_keymap("", "<LocalLeader>gh", ":Telescope help_tags<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<Leader>gw", ":Telescope grep_string<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<LocalLeader>gq", ":Telescope diagnostics<CR>", { silent = true })
--  git navigation

vim.api.nvim_set_keymap("", "<LocalLeader>gco", ":Telescope git_commits<CR>", { silent = true })
vim.api.nvim_set_keymap("", "<LocalLeader>ggs", ":Telescope git_status<CR>", { silent = true })
vim.api.nvim_set_keymap("", "<LocalLeader>ggc", ":Telescope git_bcommits<CR>", { silent = true })

local actions = require("telescope.actions")

telescope.setup {
  pickers = {
    live_grep = {
      additional_args = function(opts)
        -- show hidden files, respect the .gitignore, and ignore .git dir
        return { "--hidden", "-g", "!.git/" }
      end,
    },
  },
  defaults = {
    mappings = {
      -- when a menu pops up, press q to close in normal mode
      i = {
        ["<c-d>"] = actions.delete_buffer + actions.move_to_top
      },
      n = {
        ["q"] = actions.close
      },
    }
  }
}

telescope.load_extension("fzf")
