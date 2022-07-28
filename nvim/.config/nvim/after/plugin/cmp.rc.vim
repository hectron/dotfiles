if !exists("g:loaded_cmp")
  finish
endif

" adapted from: 
" https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion

lua << EOF
  -- Setup lspconfig.
  local nvim_lsp = require('lspconfig')

  -- Set completeopt to have a better completion experience
  vim.o.completeopt = 'menuone,noselect'

  local cmp = require('cmp')

  cmp.setup({
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end,
    },
    sources = {
      { name = 'nvim_lsp' },
    }
  })
EOF
