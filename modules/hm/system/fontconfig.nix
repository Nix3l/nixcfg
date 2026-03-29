{ lib, config, ... }:

let
    cfg = config.hm.mods.system.fonts;
in
{
    options.hm.mods.system.fonts = with lib; {
        enable = mkEnableOption "fontconfig";

        sansSerif = mkOption { default = [ "Rubik" "IPA Gothic" ]; };
        serif = mkOption { default = [ "Liberation Serif" "IPA Mincho" ]; };
        monospace = mkOption { default = [ "Fira Code" ]; };
    };

    config = lib.mkIf cfg.enable {
        fonts.fontconfig = {
            enable = true;

            defaultFonts = {
                sansSerif = cfg.sansSerif;
                serif = cfg.serif;
                monospace = cfg.monospace;
            };

            antialiasing = true;
            hinting = "slight";
            subpixelRendering = "rgb";
        };
    };
}
