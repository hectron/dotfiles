---@type Wezterm
local wezterm = require("wezterm")

-- Custom Themes
---@type Config
local config = wezterm.config_builder()
config.initial_cols = 120
config.initial_rows = 50

config.font_size = 14
config.font = wezterm.font_with_fallback({ "TX-02", "JetBrainsMono Nerd Font Propo" })

if wezterm.gui.get_appearance() ~= "Dark" then
  config.color_scheme = "catppuccin-latte"
else
  local theme = wezterm.plugin.require("https://github.com/neapsix/wezterm")
  config.colors = theme.moon.colors()
end
config.hide_tab_bar_if_only_one_tab = true
-- config.window_background_opacity = wezterm.gui.get_appearance() == "Dark" and 0.93 or 1
config.macos_window_background_blur = 20
config.window_decorations = "RESIZE"
config.window_padding = {
  top = "1cell",
  left = "1cell",
}

config.keys = {
  { key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString= "\x1bb" }) },
  { key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString= "\x1bf" }) },
}

return config
