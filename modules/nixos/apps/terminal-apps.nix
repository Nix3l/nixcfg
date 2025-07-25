{ lib, config, pkgs, ... }:

{
    options.mods.apps.terminalapps = with lib; {
        enable = mkEnableOption "download terminal apps";
    };

    config = lib.mkIf config.mods.apps.terminalapps.enable {
        environment.systemPackages = with pkgs; [
            neofetch
            unzip
            unrar
            eza
            wget
            brightnessctl
            htop
            btop
            cpustat
        ];
    };
}
