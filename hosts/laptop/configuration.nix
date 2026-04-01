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
            name ="nix3l";
            email = "momanianas123@gmail.com";
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

        dev = {
            java = {
                enable = true;
                jetbrains.enable = true;
            };

            arduino.enable = true;
            mysql.enable = true;
            unity.enable = true;
            dotnet.enable = true;
            blender.enable = true;
        };

        apps = {
            desktop = {
                enable = true;
                anki.enable = true;
            };

            util = {
                enable = true;
                mediaDownloader = true;
                obs = true;
                obsidian = true;
                hexViewer = true;
                figma = true;
            };

            media.enable = true;
            discord.enable = true;
            steam.enable = true;
            wine.enable = true;
            terminalapps.enable = true;
            minecraft.enable = true;
            pureref.enable = true;
            screenshot.enable = true;
        };

        server = {
            apache.enable = true;
        };

        fonts.enable = true;
        ld.enable = true;
    };
}
