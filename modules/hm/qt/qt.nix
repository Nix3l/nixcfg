{ lib, config, pkgs, ... }:

{
    options.hm.mods.qt = with lib; {
        enable = mkEnableOption "qt";
        darkmode = mkOption { default = true; };
    };

    config = lib.mkIf config.hm.mods.qt.enable {
        qt = {
            enable = true;
            platformTheme.name = "gtk";
            style.name = if config.hm.mods.qt.darkmode then "adwaita-dark" else "adwaita-light";
            style.package = pkgs.adwaita-qt;
        };
    };
}
