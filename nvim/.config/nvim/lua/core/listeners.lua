vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local buffer_number = event.buf

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client then
      require("core.utils.lsp_handlers").on_attach(client, buffer_number)
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function(_event)
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
  end,
})
