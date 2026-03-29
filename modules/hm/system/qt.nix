{ lib, config, pkgs, ... }:

{
    options.hm.mods.system.qt = with lib; {
        enable = mkEnableOption "qt";
    };

    config = lib.mkIf config.hm.mods.system.qt.enable {
        home.packages = with pkgs; [
            libsForQt5.qtstyleplugin-kvantum
            kdePackages.qtstyleplugin-kvantum
            libsForQt5.qt5ct
            kdePackages.qt6ct
        ];

        qt = let
            settings = {
                Appearance = {
                   style = "kvantum";
                   icon_theme = "oomox-gruvbox-dark";
                   standard_dialogs = "gtk3";
                };

                Fonts = {
                    general = "\"Rubik,9\"";
                    fixed = "\"Fira Code,9\"";
                };
            };
        in {
            enable = true;
            platformTheme.name = "qtct";
            style.name = "kvantum";

            kvantum = {
                enable = true;
                settings = {
                    General = {
                        theme = "Gruvbox-Dark-Blue";
                    };
                };

                themes = with pkgs; [
                    (gruvbox-kvantum.override {
                        variant = "Gruvbox-Dark-Blue";
                    })
                ];
            };

            qt5ctSettings = settings;
            qt6ctSettings = settings;
        };
    };
}
