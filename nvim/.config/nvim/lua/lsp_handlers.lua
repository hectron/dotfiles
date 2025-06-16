local M = {}

function M.on_attach(_, bufnr)
  local function set(modes, lhs, rhs, opts)
    local defaults = { noremap = true, silent = true, buffer = bufnr }
    local local_opts = vim.tbl_deep_extend("force", defaults, opts or {})

    vim.keymap.set(modes, lhs, rhs, local_opts)
  end

  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

  -- Navigation
  set("n", "gD", vim.lsp.buf.declaration, { desc = "[g]o to [D]eclaration" })
  set("n", "gd", vim.lsp.buf.definition)
  set("n", "<Leader>D", vim.lsp.buf.type_definition)
  set("n", "<Leader>f", vim.lsp.buf.format)

  -- Information
  set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, { desc = "Hover" })
  set({ "n", "i" }, "<C-k>", function() vim.lsp.buf.signature_help({ border = "rounded" }) end,
    { desc = "Signature help" })
  set("n", "gh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end)
  set("n", "gi", vim.lsp.buf.implementation)
  set("n", "gr", vim.lsp.buf.references)
  set("n", "<Leader>ds", vim.lsp.buf.document_symbol)

  -- Diagnostics
  set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
  set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)
  set("n", "<Leader>le", vim.diagnostic.open_float)
  -- set("n", "<Leader>q", vim.set_loclist)

  -- Refactoring
  set("n", "<Leader>rn", vim.lsp.buf.rename)
  set("n", "<Leader>ca", vim.lsp.buf.code_action)

  -- Workspaces
  set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder)
  set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder)
  set("n", "<Leader>wl", function() vim.print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
  set("n", "<Leader>ws", vim.lsp.buf.workspace_symbol)

  -- Set up diagnostics
  vim.diagnostic.config({
    virtual_text = false,
    virtual_lines = { current_line = true },
    severity_sort = true,
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
      }
    }
  })
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.lsp_servers = {
  "bashls",
  "dockerls",
  "gopls",
  "jsonnet_ls",
  "pyright",
  "puppet",
  "ruby_lsp",
  "rust_analyzer",
  {
    "lua_ls",
    opts = {
      settings = {
        Lua = {
          hint = {
            enable = true,
          },
        },
      },
    },
  },
  "terraformls",
  "ts_ls",
  "vimls",
  "yamlls",
}

function M.lsp_servers_to_install()
  local servers = {}

  for _, server in pairs(M.lsp_servers) do
    local server_name = (type(server) == "table" and server[1]) or server
    table.insert(servers, server_name)
  end

  return servers
end

return M
