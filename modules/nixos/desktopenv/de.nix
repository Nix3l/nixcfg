{ lib, config, ... }:

{
    options.mods.desktopenv = with lib; {
        enable = mkEnableOption "desktop environment";

        # can be "gnome" or "kde"
        env = mkOption {
            type = types.str;
            default = "kde";
        };
    };

    config = lib.mkIf config.mods.desktopenv.enable {
        services.displayManager.gdm = {
            enable = true;
            wayland = true;
        };

        services.desktopManager.plasma6 = lib.mkIf (config.mods.desktopenv.env == "kde") {
            enable = true;
        };

        services.desktopManager.gnome = lib.mkIf (config.mods.desktopenv.env == "gnome") {
            enable = true;
        };
    };
}
