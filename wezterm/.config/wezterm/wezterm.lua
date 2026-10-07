---@type Wezterm
local wezterm = require("wezterm")
local current_desktop = os.getenv("XDG_CURRENT_DESKTOP")
local is_linux = current_desktop == "ubuntu:GNOME"

local get_color_scheme = function(is_dark_mode)
  return is_dark_mode and "rose-pine" or "rose-pine-dawn"
end

wezterm.GLOBAL.dark_mode = wezterm.GLOBAL.dark_mode == nil and (wezterm.gui.get_appearance() == "Dark") or wezterm.GLOBAL.dark_mode

---@type Config
local config = wezterm.config_builder()
config.initial_cols = 120
config.initial_rows = 50
config.color_scheme = get_color_scheme(wezterm.GLOBAL.dark_mode)
config.font_size = is_linux and 11 or 15
config.font = wezterm.font_with_fallback({
  { family = "TX-02" },
  { family = "PragmataPro Mono" },
  "JetBrainsMono Nerd Font Propo",
  { family = "Iosevka Charon Mono", weight = "Medium" },
})

config.hide_tab_bar_if_only_one_tab = true
config.macos_window_background_blur = 20
config.window_background_opacity = wezterm.GLOBAL.dark_mode and 0.95 or 1
config.window_decorations = "RESIZE"
config.window_padding = {
  top = "1cell",
  left = "1cell",
}

-- Allow zenmode to run
wezterm.on('user-var-changed', function(window, pane, name, value)
  local overrides = window:get_config_overrides() or {}
  if name == "ZEN_MODE" then
    local incremental = value:find("+")
    local number_value = tonumber(value)
    if incremental ~= nil then
      while (number_value > 0) do
        window:perform_action(wezterm.action.IncreaseFontSize, pane)
        number_value = number_value - 1
      end
      overrides.enable_tab_bar = false
    elseif number_value < 0 then
      window:perform_action(wezterm.action.ResetFontSize, pane)
      overrides.font_size = nil
      overrides.enable_tab_bar = true
    else
      overrides.font_size = number_value
      overrides.enable_tab_bar = false
    end
  end
  window:set_config_overrides(overrides)
end)

config.keys = {
  { key = "LeftArrow",  mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
  { key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
  {
    key = "D",
    mods = "CMD",
    action = wezterm.action_callback(function(window, _)
      wezterm.GLOBAL.dark_mode = not wezterm.GLOBAL.dark_mode

      local overrides = window:get_config_overrides() or {}
      overrides.color_scheme = get_color_scheme(wezterm.GLOBAL.dark_mode)
      overrides.window_background_opacity = wezterm.GLOBAL.dark_mode and 0.95 or 1
      window:set_config_overrides(overrides)
    end),
  }
}


return config
