return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      transparent_background = true,
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      dim_inactive = true,
      transparent = true,
    },
    lazy = true,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "auto",
      dark_variant = "moon",
      dim_inactive_windows = true,
      styles = {
        bold = false,
        italic = false,
        transparency = true,
      },
    },
    config = function(_, opts)
      require("rose-pine").setup(opts)

      vim.cmd.colorscheme([[rose-pine]])
     end
  },
}
