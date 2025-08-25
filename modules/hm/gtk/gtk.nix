{ lib, config, pkgs, ... }:

{
    options.hm.mods.gtk = with lib; {
        enable = mkEnableOption "gtk";
        darkmode = mkOption { default = true; };
    };

    config = lib.mkIf config.hm.mods.gtk.enable {
        gtk.enable = true;

        dconf = {
            enable = true;
            settings = {
                "org.gnome.desktop.interface" = {
                    color-scheme = if config.hm.mods.gtk.darkmode then "dark" else "light";
                };
            };
        };

        xdg = {
            enable = true;
            portal = {
                enable = true;
                extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
                config.common.default = [ "gtk" ];
            };
        };

        home.packages = [ pkgs.glib ];
    };
}
