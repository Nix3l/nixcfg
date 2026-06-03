{ lib, config, pkgs, ... }:

# TODO: split this into multiple files

let
    cfg = config.mods.virt;
in
{
    options.mods.virt = with lib; {
        libvirtd.enable = mkEnableOption "libvirtd";
        android.enable = mkEnableOption "android virtualisation";
        virtualbox.enable = mkEnableOption "virtualbox";
    };

    config = {
        virtualisation = {
            # TODO: add waydroid-helper
            waydroid.enable = cfg.android.enable;
            libvirtd.enable = cfg.libvirtd.enable;

            virtualbox = lib.mkIf cfg.virtualbox.enable {
                host.enable = true;
                host.enableExtensionPack = true;
            };
        };
    };
}
