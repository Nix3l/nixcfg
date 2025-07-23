{ lib, config, pkgs, ... }:

{
    options.mods.apps.util = {
        enable = lib.mkEnableOption "util";
        mediaDownloader = lib.mkEnableOption "media-downloader";
        obs = lib.mkEnableOption "obs";
        obsidian = lib.mkEnableOption "obsidian";
        hexViewer = lib.mkEnableOption "hexviewer";
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
