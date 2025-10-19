local Util = require("utils")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    branch = "main",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        ft = { "markdown" },
        version = "8.*",
        opts = {
          render_modes = true,
        },
        dependencies = {
          Util.DefaultIconProvider,
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
        "regexp",
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
      local treesitter = require("nvim-treesitter")
      treesitter.setup(opts)

      treesitter.install(opts.ensure_installed)
    end,
  },
}
