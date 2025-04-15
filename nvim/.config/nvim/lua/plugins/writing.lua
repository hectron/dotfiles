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
      },
      completion = {
        blink = true,
      },
    },
    keys = {
      { "<leader>od", "<Cmd>ObsidianToday<CR>",  desc = "[o]bsidian [d]iary (today)" },
      { "<leader>of", "<Cmd>ObsidianSearch<CR>", desc = "[o]bsidian [s]earch" },
      { "<leader>on", "<Cmd>ObsidianNote<CR>",   desc = "[o]bsidian [n]ote" },
    }
  },
}
