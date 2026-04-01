{ lib, config, osConfig, pkgs, ... }:

let
    cfg = config.hm.mods.user.pfp;
    path = ../../../res/${osConfig.mods.mainUser.name}/pfp.${cfg.format};
in
{
    options.hm.mods.user.pfp = with lib; {
        enable = mkEnableOption "user pfp";
        format = mkOption { default = "png"; };
    };

    config = lib.mkIf cfg.enable {
        # incredibly stupid way of doing it lol
        home.file.".face.icon" = {
            source = path;
        };
    };
}
