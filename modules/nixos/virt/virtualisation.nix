{ lib, config, ... }:

let
    cfg = config.mods.virt;
in
{
    options.mods.virt = with lib; {
        libvirtd.enable = mkEnableOption "libvirtd";
        android.enable = mkEnableOption "android virtualisation";
    };

    config = {
        virtualisation = {
            # TODO: add waydroid-helper
            waydroid.enable = cfg.android.enable;
            libvirtd.enable = cfg.libvirtd.enable;
        };
    };
}
