{ lib, config, pkgs, ... }:

{
    options.mods.apps.media = {
        enable = lib.mkEnableOption "media";

        player = lib.mkOption {
            type = lib.types.package;
            default = pkgs.mpv;
        };

        imageViewer = lib.mkOption {
            type = lib.types.package;
            default = pkgs.nsxiv;
        };
    };

    config = lib.mkIf config.mods.apps.media.enable {
        environment.systemPackages = lib.lists.flatten (with pkgs; [
            (ffmpeg-full.override { withUnfree = true; withOpengl = true; })
        ]) ++ (with config.mods.apps.media; [
            player
            imageViewer
        ]);
    };
}
