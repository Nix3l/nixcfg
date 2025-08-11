{ lib, config, pkgs, ... }:

{
    options.mods.fonts = {
        enable = lib.mkEnableOption "fonts";

        fonts = lib.mkOption {
            type = with lib.types; listOf package;
            default = with pkgs; [
                dejavu_fonts
                nerd-fonts.iosevka
                noto-fonts
                noto-fonts-cjk-sans
                noto-fonts-emoji
                liberation_ttf
                fira-sans
                fira-code
                fira-code-symbols
                font-awesome
                font-awesome_5
                font-awesome_4
                ipafont
                kochi-substitute
                tamzen
            ];
        };

        extraFonts = lib.mkOption {
            type = with lib.types; listOf package;
            default = [];
        };
    };

    config = lib.mkIf config.mods.fonts.enable {
        environment.systemPackages = lib.lists.flatten (with config.mods.fonts; [
            fonts
            extraFonts
        ]);

        fonts.packages = lib.lists.flatten (with config.mods.fonts; [
            fonts
            extraFonts
        ]);

        fonts.fontconfig.defaultFonts = {
            monospace = [
                "FiraCode"
                "IPAGothic"
            ];

            sansSerif = [
                "FiraSans-Regular"
                "IPAGothic"
            ];

            serif = [
                "DejaVu Serif"
                "IPAGothic"
            ];
        };
    };
}
