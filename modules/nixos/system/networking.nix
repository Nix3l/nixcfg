{ lib, config, ... }:

{
    options.mods.networking = {
        enable = lib.mkEnableOption "internet";
        hostname = lib.mkOption { type = lib.types.str; };
    };

    config = lib.mkIf config.mods.networking.enable {
        networking.networkmanager.enable = true;
        networking.hostName = config.mods.networking.hostname;
    };
}
