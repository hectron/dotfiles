local nvim_lsp_installed, nvim_lsp = pcall(require, "lspconfig")

if not nvim_lsp_installed then
  print("nvim-lsp is not installed! Aborting")
  return
end

local installer_installed, nvim_lsp_installer = pcall(require, "nvim-lsp-installer")

if not installer_installed then
  print("Unable to install LSP servers because nvim-lsp-installer is not installed")
  return
end

-- Automatically install these LSP servers and set them up with proper 'on_attach' functions
local lsp_servers = {
  'bashls',
  'dockerls',
  'gopls',
  'jsonnet_ls',
  'pyright',
  'solargraph',
  'sumneko_lua',
  'terraformls',
  'vimls',
  'yamlls',
}

nvim_lsp_installer.setup({
  automatic_installation = true,
  ensure_installed = lsp_servers,
})

local on_attach = require("lsp/functions").on_attach
local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_installed, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if cmp_installed then
  capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
end

-- Specify any custom settings for an LSP server here
local server_specific_opts = {
  ['solargraph'] = function(opts)
    opts.settings = {
      filetypes = { 'ruby', 'rake' }
    }
  end,
  ['gopls'] = function(opts)
    opts.cmd = { 'gopls', '-remote=auto' }
  end,
  ['sumneko_lua'] = function(opts)
    opts.settings = {
      Lua = {
        diagnostics = {
          globals = {
            'vim',
          },
        },
      },
    }
  end,
}

for _, server_name in pairs(lsp_servers) do
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  if server_specific_opts[server_name] then
    server_specific_opts[server_name](opts)
  end

  nvim_lsp[server_name].setup(opts)
end
