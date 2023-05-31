-- plugins to check out:
-- nvim-spectre
return {
  {
    {
      "nvim-neo-tree/neo-tree.nvim",
      cmd = "Neotree",
      keys = {
        {
          "<leader>fe",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
          end,
          desc = "Explorer NeoTree",
        }
      }
    },
  },
}
