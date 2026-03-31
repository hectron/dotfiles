---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = { "markdown" },
    opts = function()
      local workspaces = {
        {
          name = "personal",
          path = "~/me/notes"
        }
      }

      local work_notes_dir = os.getenv("WORK_NOTES_DIR")

      if work_notes_dir and vim.fn.isdirectory(work_notes_dir) then
        table.insert(workspaces, { name = "work", path = work_notes_dir })
      end

      ---@module "obsidian"
      ---@type obsidian.config
      return {
        legacy_commands = false,
        workspaces = workspaces,
        daily_notes = {
          folder = "diary/" .. os.date("%Y"),
          schedule = "calendar",
        },
        completion = {
          blink = true,
        },
        ui = { enable = false },
      }
    end,
    keys = {
      { "<leader>od", "<Cmd>Obsidian today<CR>",        desc = "[o]bsidian [d]iary (today)" },
      { "<leader>os", "<Cmd>Obsidian search<CR>",       desc = "[o]bsidian [s]earch" },
      { "<leader>oq", "<Cmd>Obsidian quick_switch<CR>", desc = "[o]bsidian [q]uick switch" },
      { "<leader>on", "<Cmd>Obsidian new<CR>",          desc = "[o]bsidian [n]ote" },
      { "<leader>ot", "<Cmd>Obsidian tags<CR>",         desc = "[o]bsidian [t]ags" },
      { "<leader>oT", "<Cmd>Obsidian toc<CR>",          desc = "[o]bsidian [T]OC" },
    }
  },
  {
    "OXY2DEV/helpview.nvim",
    ft = { "markdown" },
  }
}
