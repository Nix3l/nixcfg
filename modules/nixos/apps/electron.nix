{ lib, config, ... }:

{
    options.mods.apps.electron = with lib; {
        wayland.enable = mkEnableOption "wayland electron support";
    };

    config = lib.mkIf config.mods.apps.electron.wayland.enable {
        environment.sessionVariables = {
            NIXOS_OZONE_WL = "1"; # hint at electron apps to use wayland
        };
    };
}
