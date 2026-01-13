{ lib, config, pkgs, ... }:

let
    cfg = config.mods.apps.discord;
in
{
    options.mods.apps.discord = with lib; {
        enable = mkEnableOption "discord";
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = [
            (pkgs.writeShellApplication {
                name = "discord-wayland";
                text = "NIXOS_OZONE_WL=1 ${pkgs.discord}/bin/discord --use-gl=desktop";
            })
            (pkgs.makeDesktopItem {
                name = "discord";
                exec = "discord-wayland";
                desktopName = "Discord";
            })
        ];
    };
}
