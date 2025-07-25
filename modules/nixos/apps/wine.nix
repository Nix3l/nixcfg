{ lib, config, pkgs, ... }:

{
    options.mods.apps.wine = with lib; {
        enable = mkEnableOption "wine";
    };

    config = lib.mkIf config.mods.apps.wine.enable {
        environment.systemPackages = with pkgs; [
            wineWowPackages.stable
            # native wayland support (can be unstable)
            wineWowPackages.waylandFull
            winetricks
        ];
    };
}
