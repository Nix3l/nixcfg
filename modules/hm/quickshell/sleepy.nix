{ lib, config, osConfig, ... }:

let
    cfg = config.hm.mods.sleepy;
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
            modules = {
                bluetoothStatus = mkOption { default = false; };
                powerStatus     = mkOption { default = false; };
            };

            bar = {
                height   = mkOption { default = 28; };
                vpadding = mkOption { default = 4; };
                hpadding = mkOption { default = 0; };
                numWorkspacesShown = mkOption { default = 4; };
            };

            chooser = {
                contentWidth   = mkOption { default = 800; };
                itemHeight     = mkOption { default = 64;  };
                itemSpacing    = mkOption { default = 8;   };
                maxShownItems  = mkOption { default = 6;   };
                itemPadding    = mkOption { default = 12;  };
                contentSpacing = mkOption { default = 24;  };
                promptPadding  = mkOption { default = 24;  };
                promptFontSize = mkOption { default = 18;  };
                itemFontSize   = mkOption { default = 22;  };
            };

            timing = {
                networkUpdate       = mkOption { default = 1000; };
                notifDisplayTimeout = mkOption { default = 2400; };
            };

            applauncher = {
                showIcons = mkOption { default = false; };
            };

            notifs = {
                placeRight    = mkOption { default = false; };
                width         = mkOption { default = 316;   };
                minimumHeight = mkOption { default = 56;    };
                border        = mkOption { default = 1;     };
                padding       = mkOption { default = 8;     };
                margin        = mkOption { default = 8;     };
            };
        };

        # TODO(nix3l): redo this, make sleepybind a type
        binds = {
            reload = bindOption true "R";

            applauncher = {
                open = bindOption false "R";
            };
        };
    };

    config = lib.mkIf cfg.enable {
        home.file.".config/sleepy/cfg.json" = {
            text = builtins.toJSON config.hm.mods.sleepy.cfg;
        };

        home.file.".config/sleepy/pfp.${cfg.pfp.format}" = lib.mkIf cfg.pfp.enable {
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

        wayland.windowManager.hyprland.settings.bind = with cfg.binds; [
            (sleepybind reload "reload")
            (sleepybind applauncher.open "applauncher_open")
        ];
    };
}
