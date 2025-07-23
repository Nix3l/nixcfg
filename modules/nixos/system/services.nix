{ lib, config, ... }:

{
    options.mods = {
        bluetooth.enable = lib.mkEnableOption "bluetooth";
        autoUSBMount.enable = lib.mkEnableOption "auto usb mounting";
        dconf.enable = lib.mkEnableOption "dconf";
        ssh.enable = lib.mkEnableOption "ssh";
        printing.enable = lib.mkEnableOption "printing service";
    };

    config = {
        hardware.bluetooth = {
            enable = config.mods.bluetooth.enable;
            powerOnBoot = config.mods.bluetooth.enable;
        };

        # yeah i probably shouldnt be grouping these together but who cares
        services.gvfs.enable = config.mods.autoUSBMount.enable;
        services.udisks2.enable = config.mods.autoUSBMount.enable;

        programs.dconf.enable = config.mods.dconf.enable;
        services.openssh.enable = config.mods.ssh.enable;
        services.printing.enable = config.mods.printing.enable;
    };
}
