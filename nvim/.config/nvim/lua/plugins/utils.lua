---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    ---@type snacks.Config
    opts = {
      bufdelete = { enabled = true },
      indent = { enabled = true },
      image = {
        resolve = function (path, src)
          local api = require("obsidian.api")

          if api.path_is_note(path) then
            return api.resolve_attachment_path(src)
          end
        end,
      },
      scratch = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      zen = {},
    },
    keys = {
      { "<leader>st", function() Snacks.scratch() end,     desc = "[s]cratch [t]oggle" },
      { "<leader>sp", function() Snacks.picker.lazy() end, desc = "[s]earch for [p]lugin spec" },
    },
  },
}
