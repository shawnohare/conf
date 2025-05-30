local wezterm = require('wezterm')

local config = {
   --  font = wezterm.font {
   --      family = "JetBrainsMono Nerd Font",
   --      -- family = "Monaspace Neon",
   --      weight = 'Regular',   -- default = regular
   --      -- harfbuzz_features = { "calt=1", "clig=0"},
   --  },
   font = wezterm.font(
        "JetBrainsMono Nerd Font",
        { weight = 'Regular' }
    ),
    font_size = 14,
    bold_brightens_ansi_colors = false,
    -- dpi = 144.0,
    -- freetype_load_target = "Normal",
    -- freetype_render_target = "HorizontalLcd",

    color_scheme = 'hadalized dark p3'
}

return config
