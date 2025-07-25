{ lib, config, pkgs, ... }:

{
    options.mods.apps.util = with lib; {
        enable = mkEnableOption "util";
        mediaDownloader = mkEnableOption "media-downloader";
        obs = mkEnableOption "obs";
        obsidian = mkEnableOption "obsidian";
        hexViewer = mkEnableOption "hexviewer";
    };

    config = lib.mkIf config.mods.apps.util.enable {
        environment.systemPackages = lib.lists.flatten (with pkgs; [
            grim
            slurp
            gscreenshot
            flameshot
            android-tools
            qemu
            quickemu
            bluejay
            networkmanagerapplet

            (lib.optional config.mods.apps.util.mediaDownloader media-downloader)
            (lib.optional config.mods.apps.util.obs obs-studio)
            (lib.optional config.mods.apps.util.obsidian obsidian)
            (lib.optional config.mods.apps.util.hexViewer ghex)
        ]);
    };
}
