{ lib, config, ... }:

{
    options.hm.mods.defaults = with lib; {
        enable = mkEnableOption "default app definitions";

        terminal = mkOption {
            type = types.str;
            default = "alacritty";
        };

        browser = mkOption {
            type = types.str;
            default = "librewolf";
        };

        explorer = mkOption {
            type = types.str;
            default = "thunar";
        };

        editor = mkOption {
            type = types.str;
            default = "alacritty -e nvim";
        };

        mediaPlayer = mkOption {
            type = types.str;
            default = "mpv";
        };

        imageViewer = mkOption {
            type = types.str;
            default = "nsxiv";
        };
    };

    config = lib.mkIf config.hm.mods.defaults.enable {
        home.sessionVariables = with config.hm.mods.defaults; {
            TERMINAL = terminal;
            BROWSER = browser;
            EXPLORER = explorer;
            EDITOR = editor;
            MEDIA_PLAYER = mediaPlayer;
            IMAGE_VIEWER = imageViewer;
        };
    };
}
