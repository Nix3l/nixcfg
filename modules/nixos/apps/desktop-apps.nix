{ lib, config, pkgs, ... }:

{
    options.mods.apps.desktop = {
        enable = lib.mkEnableOption "desktop apps";
        anki.enable = lib.mkEnableOption "anki";

        fileExplorer = lib.mkOption {
            type = lib.types.package;
            default = pkgs.xfce.thunar;
        };

        browser = lib.mkOption {
            type = lib.types.package;
            default = pkgs.librewolf-bin;
        };

        terminal = lib.mkOption {
            type = lib.types.package;
            default = pkgs.alacritty;
        };

        discord.enable = lib.mkOption { default = true; };
        torrent.enable = lib.mkOption { default = true; };
        office.enable = lib.mkOption { default = true; };
    };

    config = lib.mkIf config.mods.apps.desktop.enable {
        environment.systemPackages = lib.lists.flatten (with pkgs; [
            (lib.optional config.mods.apps.desktop.anki.enable anki)
            (lib.optional config.mods.apps.desktop.discord.enable discord)
            (lib.optional config.mods.apps.desktop.torrent.enable qbittorrent)
            (lib.optional config.mods.apps.desktop.office.enable libreoffice-qt6-fresh)
        ]) ++ (with config.mods.apps.desktop; [
            fileExplorer
            browser
            terminal
        ]);
    };
}
