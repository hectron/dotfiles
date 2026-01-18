---@module "lazy"
---@type LazyPluginSpec[]

--- This variable matches one of the theme configs down below,
--- and will dynamically configure the theme to properly load
---
--- The key in `plugins` MUST match the `vim.cmd.colorscheme` name
local active_colorscheme = "rose-pine"

local lazy_config = {}
local plugins = {
  catppuccin = {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      transparent_background = true,
    },
  },
  tokyonight = {
    "folke/tokyonight.nvim",
    opts = {
      dim_inactive = true,
      transparent = true,
    },
  },
  ["rose-pine"] = {
    "rose-pine/neovim",
    name = "rose-pine",
    opts = {
      variant = "auto",
      styles = {
        transparency = true,
      },
    },
  },
}

for plugin_name, lazyspec in pairs(plugins) do
  lazyspec.lazy = true

  if plugin_name == active_colorscheme then
    lazyspec.lazy = false
    lazyspec.priority = 1000

    lazyspec.config = function(_, opts)
      require(plugin_name).setup(opts)
      vim.cmd.colorscheme(plugin_name)
    end
  end

  table.insert(lazy_config, lazyspec)
end

return lazy_config
