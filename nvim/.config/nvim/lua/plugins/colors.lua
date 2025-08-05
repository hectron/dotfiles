return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      flavour = "auto",
      transparent_background = true,
    },
    -- lazy = false,
    -- config = function(_, opts)
    --   require("catppuccin").setup(opts)
    --
    --   vim.cmd.colorscheme([[catppuccin]])
    -- end
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
      variant = "auto",
      dark_variant = "moon",
      dim_inactive_windows = true,
      styles = {
        transparency = true,
      },
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)

      vim.cmd.colorscheme([[rose-pine]])
    end
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
