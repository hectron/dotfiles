local options = {
  backupcopy = "yes", -- preserves file inodes, needed for Dockerfile mounting
  clipboard = "unnamedplus", -- system clipboard
  completeopt = { "menuone", "noselect" }, -- for cmp
  cursorline = true, -- highlight the current line
  expandtab = true, -- convert tabs to spaces
  ignorecase = true, -- ignore case in searches
  number = true, -- set numbered lines
  pumheight = 10, -- popup menu height
  scrolloff = 8,
  shiftwidth = 2, -- the number of spaces insert for each indentation
  showtabline = 2, -- always show tab line
  sidescrolloff = 8,
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  smartcase = true,
  splitbelow = true, -- force horizontal splits to go below current window
  splitright = true, -- force vertical splits to go to the right of window
  swapfile = false, -- no swapfile
  tabstop = 2, -- insert 2 spaces for a tab
  termguicolors = true,
  undofile = true, -- persistent undo file
  updatetime = 300, -- faster completion (4000ms default)
  wrap = true, -- wrap lines
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

for key, value in pairs(options) do
  vim.opt[key] = value
end
