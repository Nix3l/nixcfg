{ lib, config, pkgs, ... }:

let
    cfg = config.mods.dev.blender;
in
{
    options.mods.dev.blender = with lib; {
        enable = mkEnableOption "blender";
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [ blender ];
    };
}
