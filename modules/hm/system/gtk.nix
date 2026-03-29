{ lib, config, pkgs, ... }:

let
    cfg = config.hm.mods.system.gtk;
in
{
    options.hm.mods.system.gtk = with lib; {
        enable = mkEnableOption "gtk";
    };

    config = lib.mkIf cfg.enable {
        gtk = {
            enable = true;

            theme = {
                name = "Gruvbox-Dark-Medium";
                package = (pkgs.gruvbox-gtk-theme.override {
                    colorVariants = [ "dark" ];
                    sizeVariants  = [ "standard" ];
                    themeVariants = [ "all" ];
                    tweakVariants = [ "float" "outline" "black" "medium" ];
                    iconVariants  = [ "Dark" ];
                });
            };

            iconTheme = {
                name = "Gruvbox-Plus-Dark";
                package = (pkgs.gruvbox-plus-icons.override {
                    folder-color = "grey";
                });
            };
        };

        dconf = {
            enable = true;
            settings = {
                "org.gnome.desktop.interface" = {
                    color-scheme = "dark";
                };
            };
        };

        xdg = {
            enable = true;
            portal = {
                enable = true;
                extraPortals = with pkgs; [
                    xdg-desktop-portal-gtk
                    gnome-keyring
                ];
            };
        };

        home.packages = [ pkgs.glib ];
    };
}
