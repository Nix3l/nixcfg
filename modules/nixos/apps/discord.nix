{ lib, config, pkgs, ... }:

let
    cfg = config.mods.apps.discord;
in
{
    options.mods.apps.discord = with lib; {
        enable = mkEnableOption "discord";
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [ vesktop ];
    };
}
