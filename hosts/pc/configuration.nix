{ pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    system.stateVersion = "25.05";

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    mods = {
        locale.jp = true;
        input.ime = {
            enable = true;
            jp = true;
        };

        networking = {
            enable = true;
            hostname = "nixos";
        };

        nvidia.enable = true;

        mainUser = {
            name = "nix3l";
            email = "momanianas123@gmail.com";
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
                hexViewer = true;
            };

            media.enable = true;
            steam.enable = true;
            wine.enable = true;
            terminalapps.enable = true;
            minecraft.enable = true;
        };

        dev.java.enable = true;
        dev.java.jetbrains.enable = true;

        fonts.enable = true;
        ld.enable = true;

        extraPackages = with pkgs; [
            quickshell
            (lutris.override {
                extraLibraries = pkgs: with pkgs; [
                    libadwaita
                    gtk4
                ];
            })
            renderdoc
        ];
    };

}
