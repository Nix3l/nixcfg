{ lib, config, ... }:

let
    cfg = config.hm.mods.wallpaper.hyprpaper;
in
{
    options.hm.mods.wallpaper.hyprpaper = with lib; {
        enable = mkEnableOption "wallpaper manager";

        dir = mkOption { 
            type = lib.types.path;
            default = ../../../res/walls;
        };

        wallpaper = mkOption {
            type = lib.types.str;
            default = "";
        };

        monitor = mkOption {
            type = lib.types.str;
            default = "DP-1";
        };
    };

    config = lib.mkIf cfg.enable {
        services.hyprpaper = {
            enable = true;
            settings = {
                ipc = "on";
                splash = false;

                #preload = with lib; with config.hm.mods.wallpaper.hyprpaper;
                #    lists.forEach (filesystem.listFilesRecursive dir)
                #    (p: toString p);

                preload = with cfg; [ "${toString dir}/${wallpaper}" ];
                wallpaper = with config.hm.mods.wallpaper.hyprpaper; [ "${monitor},${toString dir}/${wallpaper}" ];
            };
        };
    };
}
