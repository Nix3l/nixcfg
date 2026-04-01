{ lib, config, pkgs, ... }:

let
    cfg = config.mods.apps.screenshot;
in
{
    options.mods.apps.screenshot = with lib; {
        enable = mkEnableOption "grimblast";
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
            grim
            slurp
            gscreenshot
            grimblast
        ];
    };
}
