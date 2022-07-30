local installed, telescope = pcall(require, "telescope")

if not installed then
	return
end

local map = vim.api.nvim_set_keymap

map("n", "<LocalLeader>ff", ":Telescope find_files find_command=rg,--files,--iglob,!.git,--hidden<CR>", { silent = true })
map("n", "<LocalLeader>fb", ":Telescope buffers<CR>", { silent = true })
map("n", "<LocalLeader>ft", ":Telescope tags<CR>", { silent = true })
map("n", "<LocalLeader>fg", ":Telescope live_grep<CR>", { silent = true })
map("n", "<LocalLeader>gh", ":Telescope help_tags<CR>", { silent = true })
map("n", "<C-p>", ":Telescope find_files find_command=rg,--files,--iglob,!.git,--hidden<CR>", { silent = true })
map("n", "<Leader>gw", ":Telescope grep_string<CR>", { silent = true })

--  git navigation
map("n", "<LocalLeader>gco :Telescope git_commits<CR>", { silent = true })
map("n", "<LocalLeader>ggs :Telescope git_status<CR>", { silent = true })
map("n", "<LocalLeader>ggc :Telescope git_bcommits<CR>", { silent = true })

local actions = require("telescope.actions")

telescope.setup({
	defaults = {
		mappings = {
			n = {
				["q"] = actions.close
			},
		},
	},
})

telescope.load_extension("fzf")
