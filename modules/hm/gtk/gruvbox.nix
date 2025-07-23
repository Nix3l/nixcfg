{ lib, config, pkgs, ... }:

{
    options.hm.mods.gtk.gruvbox = with lib; {
        enable = mkEnableOption "gruvbox gtk theme";
    };

    config = lib.mkIf config.hm.mods.gtk.gruvbox.enable {
        gtk = {
            theme = {
                package = pkgs.gruvbox-gtk-theme;
                name = "Gruvbox-Dark";
            };

            iconTheme = {
                package = pkgs.gruvbox-dark-icons-gtk;
                name = "oomox-gruvbox-dark";
            };
        };
    };
}
