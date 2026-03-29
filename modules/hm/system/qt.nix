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
            kde-gruvbox
        ];

        qt = let
            settings = {
                Appearance = {
                   style = "kvantum";
                   icon_theme = "Gruvbox-Plus-Dark";
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

        home.sessionVariables =  {
            QT_STYLE_OVERRIDE = lib.mkForce "qt6ct-style";
        };

        # dont use qt*ct for kde apps, use the kde-gruvbox package (looks way nicer)
        xdg.configFile."kdeglobals" = {
            enable = true;
            text =
                ''
                    [UiSettings]
                    ColorScheme=*
                ''
                + (builtins.readFile "${pkgs.kde-gruvbox}/share/color-schemes/Gruvbox.colors");
        };
    };
}
