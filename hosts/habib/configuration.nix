{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    system.stateVersion = "25.05";

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    mods = {
        locale.en = true;
        input.ime = {
            enable = true;
            jp = false;
        };

        networking = {
            enable = true;
            hostname = "nixos";
        };

        nvidia.enable = true;

        mainUser = {
            name = "ae92";
            email = "nidi.6002@gmail.com";
            homeManager = {
                enable = true;
                module = ./home.nix;
            };
        };

        audio.enable = true;
        autoUSBMount.enable = true;
        dconf.enable = true;
        ssh.enable = true;
        printing.enable = true;
        bluetooth.enable = true;

        apps = {
            electron.wayland.enable = true;

            desktop = {
                enable = true;
            };

            util = {
                enable = true;
                mediaDownloader = true;
                obs = true;
            };

            media.enable = true;
            steam.enable = true;
            wine.enable = true;
            terminalapps.enable = true;
        };

        dev = {
            java = {
                enable = true;
                jetbrains.enable = false;
            };
        };

        fonts.enable = true;
        ld.enable = true;

        extraPackages = with pkgs; [
            ciscoPacketTracer8
        ];
    };
}
