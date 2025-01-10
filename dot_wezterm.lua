-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.default_prog = {
	"/opt/homebrew/bin/nu",
	"-c",
	"try { /opt/homebrew/bin/zellij a main } catch { try { /opt/homebrew/bin/zellij -s main } catch { /opt/homebrew/bin/zellij } }",
}
config.default_cwd = "~/Projects/"
config.hide_tab_bar_if_only_one_tab = true

config.set_environment_variables = {
	TERM = "wezterm",
}

-- For example, changing the color scheme:
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 13.0
config.font = wezterm.font({
	-- family = 'Monaspace Neon',
	-- family = 'Monaspace Argon',
	-- family = 'Monaspace Xenon',
	-- family = 'Monaspace Radon',
	-- family = 'Monaspace Krypton',
	family = "JetBrainsMono Nerd Font",
	weight = "Regular",
	harfbuzz_features = { "calt", "liga", "dlig", "ss01", "ss02", "ss03", "ss04", "ss05", "ss06", "ss07", "ss08" },
})

config.color_scheme = "Catppuccin Mocha"

config.keys = {
	{ key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
	{ key = "t", mods = "CMD", action = wezterm.action.SpawnTab("DefaultDomain") },
	{ key = "v", mods = "CMD", action = wezterm.action.PasteFrom("Clipboard") },
	{ key = "c", mods = "CMD", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },

	-- Remove annoying defaults
	{ key = "l", mods = "ALT", action = wezterm.action.DisableDefaultAssignment },
}

-- and finally, return the configuration to wezterm
return config
