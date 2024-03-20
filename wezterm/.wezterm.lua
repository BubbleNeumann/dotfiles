-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = 'AdventureTime'


config.font_size = 10.5
config.cell_width = 1.1

config.font = wezterm.font_with_fallback {
  'JetBrains Mono',
  'nonicons',
}

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.freetype_load_target = "HorizontalLcd"

config.enable_scroll_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

local act = wezterm.action
config.keys = {}
-- open the specific tab
for i = 1, 8 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = 'ALT',
    action = act.ActivateTab(i - 1),
  })
end

-- close the current tab with ctrl+w
table.insert(config.keys, {
    key = 'w',
    mods = 'CTRL',
    action = wezterm.action.CloseCurrentTab { confirm = false },
})

return config
