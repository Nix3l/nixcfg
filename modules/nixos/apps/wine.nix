{ lib, config, pkgs, ... }:

{
    options.mods.apps.wine = with lib; {
        enable = mkEnableOption "wine";
    };

    config = lib.mkIf config.mods.apps.wine.enable {
        environment.systemPackages = with pkgs; [
            wineWow64Packages.stable
            # native wayland support (can be unstable)
            wineWow64Packages.waylandFull
            winetricks
        ];
    };
}
