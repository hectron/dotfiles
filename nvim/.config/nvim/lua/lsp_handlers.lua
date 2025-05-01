local M = {}

function M.on_attach(_, bufnr)
  -- TODO switch this to use vim.keymap.set
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function set(modes, lhs, rhs, opts)
    local local_opts = vim.tbl_deep_extend("force", {}, opts, { buffer = bufnr })

    vim.keymap.set(modes, lhs, rhs, local_opts)
  end

  vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", { buf = bufnr })

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- Inspired by https://github.com/neovim/nvim-lspconfig/#keybindings-and-completion,
  -- but with <leader> instead of <space>

  -- Navigation
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "<Leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<Leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)

  -- Information
  set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, { desc = "Hover" })
  set({ "n", "i" }, "<C-k>", function() vim.lsp.buf.signature_help({ border = "rounded" }) end,
    { desc = "Signature help" })
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  set("n", "gh", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<Leader>ds", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)

  -- Diagnostics
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<Leader>le", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  buf_set_keymap("n", "<Leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

  -- Refactoring
  buf_set_keymap("n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

  -- Workspaces
  buf_set_keymap("n", "<Leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<Leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<Leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<Leader>ws", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", opts)

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

  -- Formatting
  -- vim.cmd([[
  --       augroup FORMATTING
  --         autocmd! * <buffer>
  --         autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
  --       augroup END
  --     ]])
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
