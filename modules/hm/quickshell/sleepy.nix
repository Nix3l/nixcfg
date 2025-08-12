{ lib, config, osConfig, ... }:

let
    sleepybind = b: name: "$mod ${if b.shift then "SHIFT" else ""}, ${b.key}, global, sleepy:${name}";
    bindOption = s: k: with lib; {
        shift = mkOption {
            type = types.bool;
            default = s;
        };

        key = mkOption {
            type = types.str;
            default = k;
        };
    };
in
{
    options.hm.mods.sleepy = with lib; {
        enable = mkEnableOption "sleepy";
        pfp.enable = mkEnableOption "profile picture";
        pfp.format = mkOption {
            type = types.str;
            default = "png";
        };

        cfg = {
            bar = {
                height = mkOption { default = 28; };
                vpadding = mkOption { default = 4; };
                hpadding = mkOption { default = 0; };
                numWorkspacesShown = mkOption { default = 4; };
            };

            chooser = {
                contentWidth = mkOption { default = 800; };
                itemHeight = mkOption { default = 64; };
                itemSpacing = mkOption { default = 8; };
                maxShownItems = mkOption { default = 6; };
                itemPadding = mkOption { default = 12; };
                contentSpacing = mkOption { default = 24; };
                promptPadding = mkOption { default = 24; };
                promptFontSize = mkOption { default = 18; };
                itemFontSize = mkOption { default = 22; };
            };

            timing = {
                networkUpdate = mkOption { default = 1000; };
                notifDisplayTimeout = mkOption { default = 2400; };
            };

            applauncher = {
                showIcons = mkOption { default = false; };
            };

            notifs = {
                placeRight = mkOption { default = false; };
                width = mkOption { default = 316; };
                minimumHeight = mkOption { default = 56; };
                border = mkOption { default = 1; };
                padding = mkOption { default = 8; };
                margin = mkOption { default = 8; };
            };
        };

        binds = {
            reload = bindOption true "R";

            applauncher = {
                open = bindOption false "R";
            };
        };
    };

    config = lib.mkIf config.hm.mods.sleepy.enable {
        home.file.".config/sleepy/cfg.json" = {
            text = builtins.toJSON config.hm.mods.sleepy.cfg;
        };

        home.file.".config/sleepy/pfp.${config.hm.mods.sleepy.pfp.format}" = lib.mkIf config.hm.mods.sleepy.pfp.enable {
            source = ../../../res/${osConfig.mods.mainUser.name}/pfp.${config.hm.mods.sleepy.pfp.format};
        };

        programs.quickshell = {
            enable = true;
            systemd.enable = true;
            configs = {
                "sleepy" = ../../../sleepy;  
            };

            activeConfig = "sleepy";
        };

        wayland.windowManager.hyprland.settings.bind = with config.hm.mods.sleepy.binds; [
            (sleepybind reload "reload")
            (sleepybind applauncher.open "applauncher_open")
        ];
    };
}
