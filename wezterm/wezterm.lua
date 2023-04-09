local wezterm = require "wezterm"

config = wezterm.config_builder()

config.default_prog = { "/bin/fish", "-l" }
config.color_scheme = "DoomOne"
config.window_decorations = "RESIZE"

return config