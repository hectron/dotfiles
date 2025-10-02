local lsp_handlers = require("lsp_handlers")
local Util = require("utils")

return {
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
            { path = "snacks.nvim", words = { "Snacks" } },
            { path = "lazy.nvim", words = { "LazyVim" } },
          },
        },
      },
      "SmiteshP/nvim-navic", -- breadcrumbs
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = lsp_handlers.lsp_servers_to_install(),
          automatic_installation = true,
          automatic_enable = false,
        },
        dependencies = {
          {
            "williamboman/mason.nvim",
            opts = {},
          },
        },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      for _, server in pairs(lsp_handlers.lsp_servers) do
        local opts = {
          on_attach = lsp_handlers.on_attach,
          capabilities = capabilities,
        }

        local server_name = server

        if type(server) == "table" then
          server_name = server[1]
          opts = vim.tbl_deep_extend("force", opts, {}, server.opts or {})
        end

        lspconfig[server_name].setup(opts)
      end
    end,
  },
}
