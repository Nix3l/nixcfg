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
                height = mkOption {
                    type = types.int;
                    default = 28;
                };

                vpadding = mkOption {
                    type = types.int;
                    default = 4;
                };

                hpadding = mkOption {
                    type = types.int;
                    default = 0;
                };

                numWorkspacesShown = mkOption {
                    type = types.int;
                    default = 4;
                };
            };

            timing = {
                networkUpdate = mkOption {
                    type = types.int;
                    default = 1000;
                };
            };

            applauncher = {
                width = mkOption {
                    type = types.int;
                    default = 480;
                };

                height = mkOption {
                    type = types.int;
                    default = 320;
                };

                border = mkOption {
                    type = types.int;
                    default = 2;
                };

                padding = mkOption {
                    type = types.int;
                    default = 8;
                };

                spacing = mkOption {
                    type = types.int;
                    default = 8;
                };

                promptHeight = mkOption {
                    type = types.int;
                    default = 36;
                };

                itemHeight = mkOption {
                    type = types.int;
                    default = 38;
                };
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
