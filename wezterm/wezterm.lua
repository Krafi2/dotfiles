local wezterm = require "wezterm"

config = wezterm.config_builder()

config.color_scheme = "OneDark (base16)"
config.window_decorations = "RESIZE"
config.enable_kitty_keyboard = true
config.skip_close_confirmation_for_processes_named = { "fish", "bash" }
config.swallow_mouse_click_on_window_focus = true
config.xcursor_theme = "Adwaita"

return config
