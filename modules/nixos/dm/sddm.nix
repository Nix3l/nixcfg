{ lib, config, pkgs, ... }:

let
    cfg = config.mods.dm.sddm;
    pkg = ../../../pkgs/pixie.nix;
in
{
    options.mods.dm.sddm = with lib; {
        enable = mkEnableOption "sddm";
    };

    config = lib.mkIf cfg.enable {
        systemd.services.display-manager.enable = true;
        services.displayManager.sddm = {
            enable = true;
            wayland.enable = true;
            theme = "pixie";
        };

        environment.systemPackages = [ (pkgs.callPackage pkg {}) ];
    };
}
