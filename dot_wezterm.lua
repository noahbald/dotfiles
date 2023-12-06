
-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.default_prog = { '/opt/homebrew/bin/nu' }

-- For example, changing the color scheme:
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 13.0
config.color_scheme = 'OneDark (base16)'
config.color_scheme = 'Catppuccin Mocha'

config.keys = {
    { key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
    { key = "t", mods = "CTRL", action = wezterm.action.SpawnTab "DefaultDomain" },
    { key = "v", mods = "CMD", action = wezterm.action.PasteFrom "Clipboard" },
    { key = "c", mods = "CMD", action = wezterm.action.CopyTo "ClipboardAndPrimarySelection" },
}

-- and finally, return the configuration to wezterm
return config
