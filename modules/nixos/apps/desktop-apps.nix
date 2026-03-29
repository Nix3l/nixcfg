{ lib, config, pkgs, ... }:

{
    options.mods.apps.desktop = with lib; {
        enable = mkEnableOption "desktop apps";
        anki.enable = mkEnableOption "anki";

        fileExplorer = mkOption {
            type = types.package;
            default = pkgs.kdePackages.dolphin;
        };

        browser = mkOption {
            type = types.package;
            default = pkgs.librewolf;
        };

        terminal = mkOption {
            type = types.package;
            default = pkgs.kitty;
        };

        torrent.enable = mkOption { default = true; };
        office.enable = mkOption { default = true; };
    };

    config = lib.mkIf config.mods.apps.desktop.enable {
        environment.systemPackages = lib.lists.flatten (with pkgs; [
            kdePackages.qtsvg

            (lib.optional config.mods.apps.desktop.anki.enable anki)
            (lib.optional config.mods.apps.desktop.torrent.enable qbittorrent)
            (lib.optional config.mods.apps.desktop.office.enable wpsoffice-cn)
        ]) ++ (with config.mods.apps.desktop; [
            fileExplorer
            browser
            terminal
        ]);
    };
}
