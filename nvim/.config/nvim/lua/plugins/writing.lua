---@module "lazy"
---@type LazyPluginSpec[]
return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = { "markdown" },
    opts = {
      legacy_commands = false,
      workspaces = {
        {
          name = "personal",
          path = "~/me/notes",
        },
      },
      daily_notes = {
        folder = "diary/" .. os.date("%Y"),
        schedule = "calendar",
      },
      completion = {
        blink = true,
      },
      ui = { enable = false },
    },
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
