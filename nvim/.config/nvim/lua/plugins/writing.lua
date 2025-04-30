return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = { "markdown" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
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
    },
    keys = {
      { "<leader>od", "<Cmd>ObsidianToday<CR>",       desc = "[o]bsidian [d]iary (today)" },
      { "<leader>of", "<Cmd>ObsidianSearch<CR>",      desc = "[o]bsidian [s]earch" },
      { "<leader>oq", "<Cmd>ObsidianQuickSwitch<CR>", desc = "[o]bsidian [q]uick switch" },
      { "<leader>on", "<Cmd>ObsidianNew<CR>",         desc = "[o]bsidian [n]ote" },
      { "<leader>ot", "<Cmd>ObsidianTomorrow<CR>",    desc = "[o]bsidian [t]omorrow" },
      { "<leader>oy", "<Cmd>ObsidianYesterday<CR>",   desc = "[o]bsidian [y]esterday" },
    }
  },
}
