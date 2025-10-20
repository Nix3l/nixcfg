{ lib, config, pkgs, ... }:

{
    options.mods.apps.desktop = with lib; {
        enable = mkEnableOption "desktop apps";
        anki.enable = mkEnableOption "anki";

        fileExplorer = mkOption {
            type = types.package;
            default = pkgs.xfce.thunar;
        };

        browser = mkOption {
            type = types.package;
            default = pkgs.librewolf-bin;
        };

        terminal = mkOption {
            type = types.package;
            default = pkgs.alacritty;
        };

        discord.enable = mkOption { default = false; };
        torrent.enable = mkOption { default = true; };
        office.enable = mkOption { default = true; };
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
