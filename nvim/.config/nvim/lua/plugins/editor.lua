local Util = require("utils")

return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@module "flash"
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabled = true,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "o", "x" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
  {
    "lewis6991/gitsigns.nvim", -- show line diffs inline
    event = Util.LazyFileEvents,
    opts = {},
  },
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    -- Optional dependencies
    dependencies = { Util.DefaultIconProvider },
    keys = {
      { "-", "<cmd>Oil<CR>", { desc = "Open parent directory" } },
    },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
  },
  -- {
  --   "rgroli/other.nvim", -- projectionist/a.vim alternative
  --   ft = { "ruby" },
  --   opts = {
  --     mappings = {
  --       "rails",
  --     },
  --   },
  --   keys = {
  --     { "<Leader>OF", "<cmd>Other<CR>" },
  --   },
  -- },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    ---@module "which-key"
    ---@type wk.Opts
    opts = {
      preset = "helix",
      spec = {
        { "<leader>b", desc = "Buffer" },
        { "<leader>o", desc = "Obsidian" },
      },
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer local keymaps",
      },
    },
  },
}
