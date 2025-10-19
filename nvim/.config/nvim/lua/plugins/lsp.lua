return {
  {
    "folke/lazydev.nvim",
    ft = { "lua" },
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      automatic_installation = true,
      automatic_enable = true,
    },
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {},
      },
    },
    config = function(_, opts)
      opts = vim.tbl_deep_extend("force", {}, opts or {})

      opts.ensure_installed = require("lsp_handlers").lsp_servers

      require("mason-lspconfig").setup(opts)
    end
  },
}
