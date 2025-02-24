local M = {}

function M.on_attach(_, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
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
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<Leader>ds", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", opts)

  -- Diagnostics
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<Leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
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
  -- vim.diagnostic.config({
  -- 	virtual_text = false, -- Turn off inline diagnostics
  -- })

  -- set up LSP signs
  for type, icon in pairs({
    Error = "",
    Warn = "",
    Hint = "",
    Info = "",
  }) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  -- Formatting
  vim.cmd([[
        augroup FORMATTING
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
        augroup END
      ]])
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
  "lua_ls",
  "terraformls",
  "ts_ls",
  "vimls",
  "yamlls",
}

return M
