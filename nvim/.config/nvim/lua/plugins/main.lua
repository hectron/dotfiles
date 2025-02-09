local Util = require("utils")
local lsp_handlers = require("lsp_handlers")

return {
  -- General DevEx
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
  {
    "ibhagwan/fzf-lua",
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
    keys = {
      {
        "<Leader><Leader>",
        function()
          require("fzf-lua").files()
        end,
        { desc = "fzf files" },
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim", -- UI to browse through basically anything
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      {
        "<C-p>",
        "<cmd>Telescope find_files find_command=rg,--files,--iglob,!.git,--hidden<CR>",
        desc = "Telescope: File picker",
      },
      {
        "<LocalLeader>fb",
        "<cmd>Telescope buffers<CR>",
        desc = "Telescope: [f]ind [b]uffers",
      },
      {
        "<LocalLeader>fc",
        "<cmd>Telescope commands<CR>",
        desc = "Telescope: [f]ind [c]ommands",
      },
      {
        "<LocalLeader>fg",
        "<cmd>Telescope live_grep<CR>",
        desc = "Telescope: [f]uzzy [g]rep",
      },
      {
        "<LocalLeader>fm",
        "<cmd>Telescope keymaps<CR>",
        desc = "Telescope: [f]ind key[m]aps",
      },
      {
        "<LocalLeader>mp",
        "<cmd>Telescope man_pages<CR",
        desc = "Telescope: [m]an [p]ages",
      },
      {
        "<LocalLeader>gh",
        "<cmd>Telescope help_tags<CR>",
        desc = "Telescope: [g]et [h]elp",
      },
      {
        "<Leader>gw",
        "<cmd>Telescope grep_string<CR>",
        desc = "Telescope: [g]rep highlighted [w]ord",
      },
      {
        "<LocalLeader>gq",
        "<cmd>Telescope diagnostics<CR>",
        desc = "Telescope: workspace diagnostics",
      },
      {
        "<LocalLeader>bd",
        "<cmd>Telescope diagnostics bufnr=0<CR>",
        desc = "Telescope: [b]uffer [d]iagnostics",
      },
      {
        "<Leader>be",
        "<cmd>Telescope buffers<CR>",
        desc = "Telescope: [b]uffer [e]xplore",
      },

      --  git navigation
      {
        "<LocalLeader>gco",
        "<cmd>Telescope git_commits<CR>",
        desc = "Telescope: Show [g]it [c][o]mmits",
      },
      {
        "<LocalLeader>ggs",
        "<cmd>Telescope git_status<CR>",
        desc = "Telescope: Show [g]it [g][s]tatus",
      },
      {
        "<LocalLeader>ggc",
        "<cmd>Telescope git_bcommits<CR>",
        desc = "Telescope: Show buffer's [g]it [g][c]ommits",
      },
    },
    opts = {
      pickers = {
        live_grep = {
          additional_args = function(_)
            -- show hidden files, respect the .gitignore, and ignore .git dir
            return { "--hidden", "-g", "!.git/" }
          end,
        },
      },
    },
  },
  {
    "benmills/vimux", -- Sends commands to tmux
    ft = { "ruby" },
    dependencies = {
      "vim-test/vim-test", -- Run tests in conjuction with vimux
    },
    keys = {
      { "<Leader>rb", ":wa<CR>:TestFile<CR>" },
      { "<Leader>rf", ":wa<CR>:TestNearest<CR>" },
      { "<Leader>rl", ":wa<CR>:TestLast<CR>" },
      { "<Leader>rx", ":wa<CR>:VimuxCloseRunner<CR>" },
      { "<Leader>ri", ":wa<CR>:VimuxInspectRunner<CR>" },
      { "<Leader>rs", ":!ruby -c %<CR>" },
      { "<Leader>AA", ":A<CR>" },
      { "<Leader>AV", ":AV<CR>" },
      { "<Leader>AS", ":AS<CR>" },
    },
  },
  -- Language plugins
  {
    "vim-ruby/vim-ruby",
    ft = { "ruby" },
  },
  {
    "tpope/vim-rails",
    ft = { "ruby" },
  },
  {
    "leafgarland/typescript-vim",
    ft = { "typescript" },
  },
  {
    "fatih/vim-go",
    ft = { "go" },
    build = ":GoUpdateBinaries",
  },

  -- LSP setup
  {
    "neovim/nvim-lspconfig",
    event = Util.LazyFileEvents,
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = { "lua" },
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
      "SmiteshP/nvim-navic", -- breadcrumbs
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          automatic_installation = true,
          ensure_installed = lsp_handlers.lsp_servers,
        },
        dependencies = {
          {
            "williamboman/mason.nvim",
            opts = {},
          },
        },
        lazy = true,
      },
    },
    config = function(_, _)
      local lspconfig = require("lspconfig")

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for _, server_name in pairs(lsp_handlers.lsp_servers) do
        local opts = {
          on_attach = lsp_handlers.on_attach,
          capabilities = capabilities,
        }

        lspconfig[server_name].setup(opts)
      end
    end,
  },
}
