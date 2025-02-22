return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,
    },
    priority = 1000,
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme([[catppuccin]])
    end
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      dim_inactive = true,
      transparent = true,
    },
  },
}
