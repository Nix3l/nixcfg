{ lib, config, pkgs, ... }:

let
    cfg = config.mods.kernel.latest;
in
{
    options.mods.kernel.latest = with lib; {
        enable = mkEnableOption "latest kernel";
    };

    config = lib.mkIf cfg.enable {
        boot.kernelPackages = pkgs.linuxPackages_latest; 
    };
}
