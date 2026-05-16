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

        kernel.latest.enable = true;

        mainUser = {
            name = "ae92";
            email = "nidi.6002@gmail.com";
            homeManager = {
                enable = true;
                module = ./home.nix;
            };
        };

        laptop.lid.disableSleepOnClose = true;

        system = {
            audio.enable = true;
            autoUSBMount.enable = true;
            dconf.enable = true;
            ssh.enable = true;
            printing.enable = true;
            bluetooth.enable = true;
            upower.enable = true;
            appimage.enable = true;
            keyring.enable = true;
        };

        dm = {
            sddm.enable = true;
        };

        desktop = {
            hyprland.enable = true;
        };

        apps = {
            desktop = {
                enable = true;
            };

            util = {
                enable = true;
                mediaDownloader = true;
                obs = true;
                obsidian = true;
                figma = true;
            };

            media.enable = true;
            discord.enable = true;
            steam.enable = true;
            wine.enable = true;
            terminalapps.enable = true;
            pureref.enable = true;
            screenshot.enable = true;
        };

        dev = {
            java = {
                enable = true;
                jetbrains.enable = true;
            };

            mysql.enable = true;
        };

        server = {
            apache.enable = true;
        };

        fonts.enable = true;
        ld.enable = true;

        extraPackages = with pkgs; [
            quickemu
            projectlibre
            chromium
        ];
    };
}
