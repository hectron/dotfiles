return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,
    },
    lazy = false,
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
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "moon",
      dim_inactive_windows = true,
    },
  },
  {
    "scottmckendry/cyberdream.nvim",
    opts = {},
  },
  {
    "echasnovski/mini.colors",
    opts = {},
  },
  {
    "hectron/spinel.nvim",
    opts = {
      transparent = true,
      style = "dark",
    },
  },
}
