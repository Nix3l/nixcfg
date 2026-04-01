{ lib, config, ... }:

let
    cfg = config.mods.desktop.hyprland;
in
{
    options.mods.desktop.hyprland = with lib; {
        enable = mkEnableOption "hyprland";
    };

    config = lib.mkIf cfg.enable {
        programs.hyprland = {
            enable = true;
            withUWSM = true;
            xwayland.enable = true;
        };
    };
}
