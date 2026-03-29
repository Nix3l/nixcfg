{ lib, config, pkgs, ... }:

let
    cfg = config.mods.system;
in
{
    options.mods.system = with lib; {
        bluetooth.enable = mkEnableOption "bluetooth";
        autoUSBMount.enable = mkEnableOption "auto usb mounting";
        dconf.enable = mkEnableOption "dconf";
        upower.enable = mkEnableOption "upower";

        ssh = {
            enable = mkEnableOption "ssh";
            rootAuthorizedKeys = mkOption {
                type = with types; listOf str;
                default = [];
            };
        };

        keyring.enable = mkEnableOption "keyring";
        printing.enable = mkEnableOption "printing service";
    };

    config = {
        hardware.bluetooth = {
            enable = cfg.bluetooth.enable;
            powerOnBoot = cfg.bluetooth.enable;
        };

        environment.systemPackages = lib.mkIf cfg.bluetooth.enable (with pkgs; [
            bluejay
        ]);

        # yeah i probably shouldnt be grouping these together but who cares
        services.gvfs.enable = cfg.autoUSBMount.enable;
        services.udisks2.enable = cfg.autoUSBMount.enable;

        programs.dconf.enable = cfg.dconf.enable;

        services.upower.enable = lib.mkForce cfg.upower.enable;

        services.openssh.enable = cfg.ssh.enable;
        users.users.root.openssh.authorizedKeys.keys = lib.mkIf cfg.ssh.enable cfg.ssh.rootAuthorizedKeys;

        services.printing.enable = cfg.printing.enable;

        services.gnome.gnome-keyring.enable = cfg.keyring.enable;
        security.pam.services.login.enableGnomeKeyring = cfg.keyring.enable;
    };
}
