return {
  { "stevearc/dressing.nvim" },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "|",
      filetype_exclude = { "help", "lazy", "mason" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },

  { "MunifTanjim/nui.nvim", lazy = true },
}
