{ lib, config, ... }:

{
    options.hm.mods.alacritty = with lib; {
        enable = mkEnableOption "alacritty";
        shell = mkOption { default = "zsh"; };
        gruvbox = mkOption { default = true; };
        font = mkOption { default = "FiraCode"; };
    };

    config = lib.mkIf config.hm.mods.alacritty.enable {
        programs.alacritty = {
            enable = true;
            settings = with config.hm.mods.alacritty; {
                terminal.shell = shell;
                cursor.style = "beam";

                font.normal.family = font;
                font.size = 12;

                colors = lib.mkIf gruvbox {
                    primary = {
                        background = "#282828";
                        foreground = "#ebdbb2";
                    };

                    normal = {
                        black   = "#282828";
                        red     = "#cc241d";
                        green   = "#98971a";
                        yellow  = "#d79921";
                        blue    = "#458588";
                        magenta = "#b16286";
                        cyan    = "#689d6a";
                        white   = "#a89984";
                    };

                    bright = {
                        black   = "#928374";
                        red     = "#fb4934";
                        green   = "#b8bb26";
                        yellow  = "#fabd2f";
                        blue    = "#83a598";
                        magenta = "#d3869b";
                        cyan    = "#8ec07c";
                        white   = "#ebdbb2";
                    };
                };

                window.padding = {
                    x = 8;
                    y = 8;
                };
            };
        };
    };
}
