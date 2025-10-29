{ lib, config, ... }:

let
    cfg = config.hm.mods.kitty;
in
{
    options.hm.mods.kitty = with lib; {
        enable = mkEnableOption "kitty";
        font = {
            family = mkOption { default = "monospace"; };
            size = mkOption { default = 12; };
        };

        colors = {
            black.dull     = mkOption { default = "#282828"; };
            black.bright   = mkOption { default = "#928374"; };
            red.dull       = mkOption { default = "#cc241d"; };
            red.bright     = mkOption { default = "#fb4934"; };
            green.dull     = mkOption { default = "#98971a"; };
            green.bright   = mkOption { default = "#b8bb26"; };
            yellow.dull    = mkOption { default = "#d79921"; };
            yellow.bright  = mkOption { default = "#fabd2f"; };
            blue.dull      = mkOption { default = "#458588"; };
            blue.bright    = mkOption { default = "#83a598"; };
            magenta.dull   = mkOption { default = "#b16286"; };
            magenta.bright = mkOption { default = "#d3869b"; };
            cyan.dull      = mkOption { default = "#689d6a"; };
            cyan.bright    = mkOption { default = "#8ec07c"; };
            white.dull     = mkOption { default = "#a89984"; };
            white.bright   = mkOption { default = "#ebdbb2"; };
        };
    };

    config = lib.mkIf cfg.enable {
        programs.kitty = {
            enable = true;
            font = {
                name = cfg.font.family;
                size = cfg.font.size;
            };

            settings = {
                cursor_shape = "beam";
                enable_audio_bell = false;
                update_check_interval = 0;
                confirm_os_window_close = 0;

                window_padding_width = 8;

                background = cfg.colors.black.dull;
                foreground = cfg.colors.white.dull;

                color0  = cfg.colors.white.dull;
                color8  = cfg.colors.white.bright;
                color1  = cfg.colors.black.dull;
                color9  = cfg.colors.black.bright;
                color2  = cfg.colors.red.dull;
                color10 = cfg.colors.red.bright;
                color3  = cfg.colors.green.dull;
                color11 = cfg.colors.green.bright;
                color4  = cfg.colors.yellow.dull;
                color12 = cfg.colors.yellow.bright;
                color5  = cfg.colors.blue.dull;
                color13 = cfg.colors.blue.bright;
                color6  = cfg.colors.magenta.dull;
                color14 = cfg.colors.magenta.bright;
                color7  = cfg.colors.cyan.dull;
                color15 = cfg.colors.cyan.bright;
            };
        };
    };
}
