return {
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   opts = {
  --     flavour = "latte",
  --     transparent_background = true,
  --   },
  --   config = function(_, opts)
  --     require("catppuccin").setup(opts)
  --     vim.cmd.colorscheme([[catppuccin]])
  --   end,
  -- },
  -- {
  --   "folke/tokyonight.nvim",
  --   opts = {
  --     dim_inactive = true,
  --     transparent = true,
  --     style = "day",
  --   }
  -- },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "dawn",
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
  {
    "scottmckendry/cyberdream.nvim",
    opts = {
      variant = "light",
      transparent = true,
      borderless_pickers = true,
    },
    -- config = function(_, opts)
    --   require("cyberdream").setup(opts)
    --   vim.cmd.colorscheme([[cyberdream]])
    -- end,
  },
  -- {
  --   "hectron/spinel.nvim",
  --   opts = {
  --     transparent = true,
  --     style = "dark",
  --   },
  -- },
}
