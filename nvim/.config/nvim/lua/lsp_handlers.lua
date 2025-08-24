local M = {}

function M.on_attach(_, bufnr)
  --- Wrapper for `vim.keymap.set`.
  ---
  --- Sets default opts values to:
  --- keymaps are for buffer LSP is attached to
  --- prefixes description with `LSP: `
  ---
  --- @param modes string|string[]
  --- @param lhs string
  --- @param rhs string|function
  --- @param opts? vim.keymap.set.Opts
  local function set(modes, lhs, rhs, opts)
    local defaults = { noremap = true, silent = true, buffer = bufnr }
    local local_opts = vim.tbl_deep_extend("force", defaults, opts or {})

    local lsp_desc_prefix = "LSP: "
    if local_opts.desc ~= nil and local_opts.desc:sub(1, #lsp_desc_prefix) ~= lsp_desc_prefix then
      local_opts.desc = lsp_desc_prefix .. local_opts.desc
    end

    vim.keymap.set(modes, lhs, rhs, local_opts)
  end

  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

  -- Navigation
  set("n", "gD", vim.lsp.buf.declaration, { desc = "[g]o to [D]eclaration" })
  set("n", "gd", vim.lsp.buf.definition, { desc = "[g]o to [d]efinition" })
  set("n", "<Leader>D", vim.lsp.buf.type_definition, { desc = "type [D]efinition"})
  set("n", "<Leader>F", vim.lsp.buf.format, { desc = "[F]ormat" })

  -- Information
  set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, { desc = "Hover" })
  set({ "n", "i" }, "<C-k>", function() vim.lsp.buf.signature_help({ border = "rounded" }) end,
    { desc = "Signature help" })
  set("n", "gh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "inlay hint" })
  set("n", "gi", vim.lsp.buf.implementation, { desc = "[g]o to [i]mplementation" })
  set("n", "gr", vim.lsp.buf.references, { desc = "[g]et [r]eferences" })
  set("n", "<Leader>ds", vim.lsp.buf.document_symbol, { desc = "[d]ocument [s]ymbol" })

  -- Diagnostics
  set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "previous [d]iagnostic" })
  set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "next [d]iagnostic" })
  set("n", "<Leader>le", vim.diagnostic.open_float, { desc = "[l]ine [e]xplain diagnostic" })
  -- set("n", "<Leader>q", vim.set_loclist)

  -- Refactoring
  set("n", "<Leader>rn", vim.lsp.buf.rename, { desc = "[r]e[n]ame" })
  set("n", "<Leader>ca", vim.lsp.buf.code_action, { desc = "[c]ode [a]ction" })

  -- Workspaces
  set("n", "<Leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "[w]orkspace [a]dd folder" })
  set("n", "<Leader>wr", vim.lsp.buf.remove_workspace_folder, { desc = "[w]orkspace [r]emove folder" })
  set("n", "<Leader>wl", function() vim.print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, { desc = "[w]orkspace [l]ist folders" })
  set("n", "<Leader>ws", vim.lsp.buf.workspace_symbol, { desc = "[w]orkspace [s]ymbol" })

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
