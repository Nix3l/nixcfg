{ lib, config, ... }:

{
    options.hm.mods.quickshell = with lib; {
        enable = mkEnableOption "quickshell";
    };

    config = lib.mkIf config.hm.mods.quickshell.enable {
        programs.quickshell = {
            enable = true;
            systemd.enable = true;
        };
    };
}
