local Util = require("utils")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = Util.LazyFileEvents,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/nvim-treesitter-context",
      "RRethy/nvim-treesitter-endwise",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        opts = {},
        dependencies = {
          "nvim-tree/nvim-web-devicons",
        },
      },
    },
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "dockerfile",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "go",
        "hcl",
        "javascript",
        "json",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "python",
        "puppet",
        "query",
        "ruby",
        "rust",
        "yaml",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
      },                   -- this is available in the list of official parsers
      ignore_install = {}, -- list of parsers to ignore installing
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
      },
      textobjects = {
        select = {
          enable = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["av"] = "@block.outer",
            ["iv"] = "@block.inner",
          },
        },
      },
      endwise = {
        enable = true,
      },
    },
    config = function(_, opts)
      local configs = require("nvim-treesitter.configs")
      configs.setup(opts)
    end,
  },
}
