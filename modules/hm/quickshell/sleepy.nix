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
            style = {
                colors = {
                    bg0  = mkOption { default = "#1d2021"; };
                    bg1  = mkOption { default = "#3c3836"; };
                    fg0  = mkOption { default = "#a89984"; };
                    fg1  = mkOption { default = "#ebdbb2"; };
                    acc0 = mkOption { default = "#689d6a"; };
                    acc1 = mkOption { default = "#8ec07c"; };
                    alt0 = mkOption { default = "#458588"; };
                    alt1 = mkOption { default = "#83a598"; };
                };

                border = {
                    thin   = mkOption { default = 1; };
                    normal = mkOption { default = 2; };
                    thick  = mkOption { default = 4; };
                };

                rounding = {
                    normal = mkOption { default = 8; };
                    heavy  = mkOption { default = 12; };
                    full   = mkOption { default = 9999; };
                };

                padding = {
                    smallest = mkOption { default = 4; };
                    small    = mkOption { default = 8; };
                    normal   = mkOption { default = 12; };
                    large    = mkOption { default = 16; };
                    largest  = mkOption { default = 24; };
                };

                spacing = {
                    smallest = mkOption { default = 2; };
                    small    = mkOption { default = 4; };
                    normal   = mkOption { default = 8; };
                    large    = mkOption { default = 12; };
                    largest  = mkOption { default = 16; };
                };

                fonts = {
                    normal = mkOption { default = "Rubik"; };
                    mono   = mkOption { default = "Tamzen"; };
                };

                text = {
                    smallest = mkOption { default = 8; };
                    small    = mkOption { default = 9; };
                    normal   = mkOption { default = 11; };
                    large    = mkOption { default = 14; };
                    largest  = mkOption { default = 22; };
                    colossal = mkOption { default = 38; };
                };

                icons = {
                    smallest = mkOption { default = 12; };
                    small    = mkOption { default = 14; };
                    normal   = mkOption { default = 16; };
                    large    = mkOption { default = 22; };
                    largest  = mkOption { default = 32; };
                };
            };

            modules = {
                bluetooth = mkOption { default = false; };
                power     = mkOption { default = false; };
            };

            bar = {
                height   = mkOption { default = 32; };
                vpadding = mkOption { default = 4; };
                hpadding = mkOption { default = 4; };
                numWorkspacesShown = mkOption { default = 4; };
            };

            timing = {
                networkUpdate       = mkOption { default = 1000; };
                brightnessUpdate    = mkOption { default = 1000; };
                notifDisplayTimeout = mkOption { default = 2400; };
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

            clock = {
                fmt12Hour = mkOption { default = false; };
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
