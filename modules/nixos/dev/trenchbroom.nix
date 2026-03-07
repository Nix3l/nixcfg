{ lib, config, pkgs, ... }:

let
    cfg = config.mods.dev.trenchbroom;
    pkg = ../../../pkgs/trenchbroom.nix;
in
{
    options.mods.dev.trenchbroom = with lib; {
        enable = mkEnableOption "trenchbroom";
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = [ (pkgs.callPackage pkg {}) ];
    };
}
