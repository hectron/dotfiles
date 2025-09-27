local M = {}

M.LazyFileEvents = { "BufReadPost", "BufNewFile", "BufWritePre" }
M.DefaultIconProvider = { "nvim-mini/mini.icons", opts = {} }

return M
