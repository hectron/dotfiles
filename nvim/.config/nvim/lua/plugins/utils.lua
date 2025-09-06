return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    ---@type snacks.Config
    opts = {
      bufdelete = { enabled = true },
      indent = { enabled = true },
      scratch = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      zen = {},
    },
    keys = {
      { "<leader>st", function() Snacks.scratch() end, desc = "[s]cratch [t]oggle" },
    },
  },
}
