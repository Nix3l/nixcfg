{ lib, config, ... }:

{
    options.mods.apps.steam = with lib; {
        enable = mkEnableOption "steam";
    };

    config = lib.mkIf config.mods.apps.steam.enable {
        programs.steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
        };
    };
}
