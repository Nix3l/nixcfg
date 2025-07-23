{ lib, config, pkgs, ... }:

{
    options.mods.apps.terminalapps = {
        enable = lib.mkEnableOption "download terminal apps";
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
