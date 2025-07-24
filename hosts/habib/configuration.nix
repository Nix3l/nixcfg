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
                anki.enable = true;
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

        desktopenv = {
            enable = true;
            env = "gnome";
        };

        dev = {
            java = {
                enable = true;
                jetbrains.enable = true;
            };
        };

        fonts.enable = true;
        ld.enable = true;

        extraPackages = with pkgs; [
            # any extra apps go here
        ];
    };
}
