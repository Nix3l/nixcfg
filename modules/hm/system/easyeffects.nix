{ config, lib, ... }:

let
    cfg = config.hm.mods.system.audio.effects;
in
{
    options.hm.mods.system.audio.effects = with lib; {
        enable = mkEnableOption "easyeffects";
        preset = mkOption { default = ""; };
    };

    config = lib.mkIf cfg.enable {
        services.easyeffects = {
            enable = true;
            preset = cfg.preset;
        };
    };
}
