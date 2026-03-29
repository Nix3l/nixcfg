{ lib, config, pkgs, ... }:

let
    cfg = config.mods.apps.pureref;
in
{
    options.mods.apps.pureref = with lib; {
        enable = mkEnableOption "pureref";
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = [ pkgs.pureref ];
    };
}
