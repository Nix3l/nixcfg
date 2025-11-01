{ lib, config, osConfig, ... }:

let
    monitorType = lib.types.submodule {
        options = with lib; {
            name = mkOption { type = types.str; };
            resolution = mkOption { type = types.str; };
            refreshRate = mkOption { type = types.int; };
            mirror.enable = mkEnableOption "enable mirroring";
            mirror.from = mkOption { type = types.str; };
        };
    };
in {
    options.hm.mods.hyprland = with lib; {
        enable = mkEnableOption "hyprland";
        monitors = mkOption { type = types.listOf monitorType; };
    };

    config = lib.mkIf config.hm.mods.hyprland.enable {
        wayland.windowManager.hyprland = {
            enable = true;
            systemd.enable = true;
            xwayland.enable = true;

            settings = {
                # MONITOR
                monitor = lib.lists.forEach config.hm.mods.hyprland.monitors (m:
                    lib.concatStrings [
                        "${m.name},${m.resolution}@${toString m.refreshRate},auto,1"
                        (if m.mirror.enable then ",mirror,${m.mirror.from}" else "")
                    ]
                );

                # LOOK
                general = {
                    border_size = 2;

                    gaps_in = 5; # between windows
                    gaps_out = 10; # between windows and montor edge

                    "col.inactive_border" = "0xff928374";
                    "col.active_border" = "0xffebdbb2";

                    layout = "diwndle";

                    resize_on_border = false;
                };

                decoration = {
                    rounding = 0;

                    active_opacity = 0.96;
                    inactive_opacity = 0.90;

                    dim_inactive = false;

                    blur = {
                        enabled = true;
                        xray = true;
                        special = false;
                        new_optimizations = true;
                        size = 10;
                        passes = 2;
                        brightness = 1;
                        noise = 0.01;
                        contrast = 1;
                        popups = true;
                        popups_ignorealpha = 0.6;
                        input_methods = true;
                        input_methods_ignorealpha = 0.8;
                    };

                    shadow = {
                        enabled = false;
                    };

                    # you can just add a custom shader wow
                    # that is actually awesome
                    # screen_shader = "";
                };

                cursor = {
                    no_hardware_cursors = false;
                    use_cpu_buffer = 0;
                };

                # INPUT
                "$mod" = "SUPER";

                "$terminal" = config.home.sessionVariables.TERMINAL;
                "$browser"  = config.home.sessionVariables.BROWSER;
                "$explorer" = config.home.sessionVariables.EXPLORER;

                input = {
                    kb_layout = "us";
                    touchpad = { natural_scroll = true; };

                    repeat_rate = 45;
                    repeat_delay = 200;
                };

                bind = lib.lists.flatten [
                    "$mod, W, killactive"
                    "$mod SHIFT, Q, exit"
                    "$mod, S, togglefloating"
                    "$mod, F, fullscreen"

                    "$mod, 1, workspace, 1"
                    "$mod, 2, workspace, 2"
                    "$mod, 3, workspace, 3"
                    "$mod, 4, workspace, 4"

                    "$mod SHIFT, 1, movetoworkspace, 1"
                    "$mod SHIFT, 2, movetoworkspace, 2"
                    "$mod SHIFT, 3, movetoworkspace, 3"
                    "$mod SHIFT, 4, movetoworkspace, 4"

                    "$mod, left, movefocus, l"
                    "$mod, right, movefocus, r"
                    "$mod, up, movefocus, u"
                    "$mod, down, movefocus, d"

                    "$mod, RETURN, exec, $terminal"
                    "$mod, B, exec, $browser"
                    "$mod SHIFT, B, exec, $browser --private-window"
                    "$mod, E, exec, $explorer"
                    (lib.optional osConfig.mods.apps.util.enable "$mod SHIFT, S, exec, flameshot gui")
                ];

                binde = [
                    ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
                    ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
                    ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
                    ",XF86MonBrightnessUp, exec, brightnessctl set +15%"
                    ",XF86MonBrightnessDown, exec, brightnessctl set 15%-"
                ];

                bindm = [
                    "$mod, mouse:272, movewindow"
                    "$mod, mouse:273, resizewindow"
                ];

                exec-once = lib.lists.flatten [
                    (lib.optional osConfig.mods.apps.util.enable "flameshot &")
                    (lib.optional osConfig.mods.input.ime.enable "fcitx5 &")
                    # (supposedly) fixes cursor themes in gnome apps under hyprland
                    "gsettings set org.gnome.desktop.interface cursor-theme '${config.home.pointerCursor.name}'"
                    "gsettings set org.gnome.desktop.interface cursor-size ${toString config.home.pointerCursor.size}"
                ];

                misc = {
                    disable_hyprland_logo = true;
                    disable_splash_rendering = true;
                };
            };
        };
    };
}
