-- adapted from:
-- https://github.com/neovim/nvim-lspconfig/wiki/Autocompletion
local cmp_exists, cmp = pcall(require, "cmp")

if not cmp_exists then
  return
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

local luasnip_installed, luasnip = pcall(require, "luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      if luasnip_installed then
        luasnip.lsp_expand(args.body)
      else
        print("Could not configure cmp + luasnip :(")
      end
    end
  },
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
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  }, {
    { name = 'buffer' },
  })
})
