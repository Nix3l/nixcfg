{ pkgs, ... }:

{
    imports = [ ./hardware-configuration.nix ];

    system.stateVersion = "25.05";

    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;

    mods = {
        locale.en = true;
        networking = {
            enable = true;
            hostname = "homelab";
        };

        laptop.lid.disableSleepOnClose = true;

        mainUser. name = "nix3l";

        ssh = {
            enable = true;
            rootAuthorizedKeys = [
                # home pc
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHq2Ln1LM7XcdljuQd9BGU952zh8w8zyXB5Kpb+kfkxD nix3l@nixos"
            ];
        };

        server = {
            copyparty.enable = true;
        };

        extraPackages = [ pkgs.cloudflared ];
    };
}
