local wezterm = require("wezterm")

local config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	color_scheme = "Catppuccin Mocha", -- Mocha, Macchiato, Frappe, Latte
	font = wezterm.font("Maple Mono NF CN"),
	font_size = 14,
	window_background_opacity = 0.92,
	macos_window_background_blur = 10,
}

return config
