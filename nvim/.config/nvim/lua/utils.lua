-- @class user.util: UserUtil
local M = {}

function M.has(plugin)
  return require("lazy.core.config").spec.plugins[plugin] ~= nil
end

M.LazyFileEvents = { "BufReadPost", "BufNewFile", "BufWritePre" }

return M
