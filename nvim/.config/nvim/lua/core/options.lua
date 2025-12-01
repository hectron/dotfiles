local opt = vim.opt

opt.backupcopy = "yes"                                         -- preserves file inodes, needed for Dockerfile mounting
opt.clipboard = vim.env.SSH_CONNECTION and "" or "unnamedplus" -- Sync w/system clipboard unless in SSH mode (to support OSC 52)
opt.completeopt = { "menuone", "noselect" }                    -- for cmp
opt.conceallevel = 2                                           -- Hide * markup for bold/italic, but not markers with substitutions
opt.cursorline = true                                          -- highlight the current line
opt.cursorlineopt = "number"
opt.expandtab = true                                           -- convert tabs to spaces
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldlevel = 99
opt.foldmethod = "indent"
opt.foldtext = ""
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true                                          -- ignore case in searches
opt.linebreak = true                                           -- visually split long lines
opt.list = true                                                -- show some invisible characters
opt.number = true                                              -- set numbered lines
opt.pumheight = 10                                             -- popup menu height
opt.relativenumber = true
opt.ruler = false
opt.scrolloff = 8
opt.shiftwidth = 2      -- the number of spaces insert for each indentation
opt.showtabline = 2     -- always show tab line
opt.sidescrolloff = 8
opt.signcolumn = "yes"  -- always show the sign column, otherwise it would shift the text each time
opt.smartcase = true
opt.smartindent = true
opt.spelllang = { "en" }
opt.splitbelow = true   -- force horizontal splits to go below current window
opt.splitright = true   -- force vertical splits to go to the right of window
opt.swapfile = false    -- no swapfile
opt.tabstop = 2         -- insert 2 spaces for a tab
opt.termguicolors = true
opt.undofile = true     -- persistent undo file
opt.updatetime = 300    -- faster completion (4000ms default)
opt.wrap = true         -- wrap lines
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

vim.filetype.add({
  extension = {
    tf = "terraform",
  },
})
