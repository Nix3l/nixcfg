{ lib, config, pkgs, ... }:

{
    options.mods.apps.media = with lib; {
        enable = mkEnableOption "media";

        player = mkOption {
            type = types.package;
            default = pkgs.mpv;
        };

        imageViewer = mkOption {
            type = types.package;
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
