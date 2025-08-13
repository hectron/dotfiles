local wezterm = require("wezterm")

-- Custom Themes
local config = wezterm.config_builder()
config.initial_cols = 120
config.initial_rows = 50

config.font_size = 14
--- config.font = wezterm.font("BerkeleyMono Nerd Font Mono")
config.font = wezterm.font("TX-02")

config.color_scheme = "rose-pine-moon"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.93
config.window_decorations = "RESIZE"
config.window_padding = {
  top = "1.5cell",
  left = "1.5cell",
}

config.keys = {
  { key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString= "\x1bb" }) },
  { key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString= "\x1bf" }) },
}

return config
