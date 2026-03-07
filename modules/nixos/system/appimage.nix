{ lib, config, ... }:

let
    cfg = config.mods.system.appimage;
in
{
    options.mods.system.appimage = with lib; {
        enable = mkEnableOption "appimage";
    };

    config = lib.mkIf cfg.enable {
        programs.appimage = {
            enable = true;
            binfmt = true;
        };
    };
}
