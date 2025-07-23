{ lib, config, pkgs, inputs, ... }:

{
    options.hm.mods.spotify = with lib; {
        enable = mkEnableOption "spotify with spicetify";
    };

    config = lib.mkIf config.hm.mods.spotify.enable {
        programs.spicetify = let
            spicepkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.system};
        in {
            enable = true;
            enabledExtensions = with spicepkgs.extensions; [
                adblockify
                hidePodcasts
                fullAlbumDate
                volumePercentage
                fullScreen
            ];

            theme = spicepkgs.themes.text;
            colorScheme = "Gruvbox";
        };
    };
}
