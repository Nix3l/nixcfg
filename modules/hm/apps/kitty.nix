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

        shell = mkOption { default = config.home.sessionVariables.SHELL; };
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

                window_padding_width = 4;

                shell = cfg.shell;

                # yes im hard coding the colors sue me
                # 235_bg, 223_fg1
                background = "#282828";
                foreground = "#ebdbb2";

                # 245_gray, 237_bg1
                selection_foreground = "#928374";
                selection_background = "#3c3836";

                # 229_fg0, 236_bg0_s
                cursor = "#fbf1c7";
                cursor_text_color = "#32302f";

                # 208_orange
                url_color = "#fe8019";

                # 235_bg, 241_bg3
                color0  = "#282828";
                color8  = "#665c54";

                # 124_red, 167_red
                color1  = "#cc241d";
                color9  = "#fb4934";

                # 106_green, 142_green
                color2  = "#98971a";
                color10 = "#b8bb26";

                # 172_yellow, 214_yellow
                color3  = "#d79921";
                color11 = "#fabd2f";

                # 72_aqua, 109_blue
                color4  = "#689d6a";
                color12 = "#83a598";

                # 132_purple, 175_purple
                color5  = "#b16286";
                color13 = "#d3869b";

                # 72_aqua, 108_aqua
                color6  = "#689d6a";
                color14 = "#8ec07c";

                # 246_gray, 245_gray
                color7  = "#a89984";
                color15 = "#928374";
            };
        };

        hm.mods.session.terminal = "kitty";
    };
}
