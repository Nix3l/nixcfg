{ lib, config, ... }:

let
    cfg = config.mods;
in
{
    options.mods = with lib; {
        bluetooth.enable = mkEnableOption "bluetooth";
        autoUSBMount.enable = mkEnableOption "auto usb mounting";
        dconf.enable = mkEnableOption "dconf";

        ssh = {
            enable = mkEnableOption "ssh";
            rootAuthorizedKeys = mkOption {
                type = with types; listOf str;
                default = [];
            };
        };

        printing.enable = mkEnableOption "printing service";
    };

    config = {
        hardware.bluetooth = {
            enable = cfg.bluetooth.enable;
            powerOnBoot = cfg.bluetooth.enable;
        };

        # yeah i probably shouldnt be grouping these together but who cares
        services.gvfs.enable = cfg.autoUSBMount.enable;
        services.udisks2.enable = cfg.autoUSBMount.enable;

        programs.dconf.enable = cfg.dconf.enable;

        services.openssh.enable = cfg.ssh.enable;
        users.users.root.openssh.authorizedKeys.keys = lib.mkIf cfg.ssh.enable cfg.ssh.rootAuthorizedKeys;

        services.printing.enable = cfg.printing.enable;
    };
}
