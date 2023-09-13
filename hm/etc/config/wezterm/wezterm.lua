local wezterm = require('wezterm')

local config = {
    font = wezterm.font(
        "JetBrainsMono Nerd Font",
        { weight = 'Medium' }
    ),
    font_size = 14,
    bold_brightens_ansi_colors = false,
    -- dpi = 144.0,
    -- freetype_load_target = "Normal",
    -- freetype_render_target = "HorizontalLcd",

    color_scheme = 'hadalized dark p3'
}

return config
