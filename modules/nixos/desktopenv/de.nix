{ lib, config, ... }:

{
    options.mods.de = with lib; {
        enable = mkEnableOption "desktop environment";

        # can be "gnome" or "kde"
        env = mkOption {
            type = types.str;
            default = "kde";
        };
    };

    config = lib.mkIf config.mods.de.enable {
        services.displayManager.gdm = {
            enable = true;
            wayland = true;
        };

        services.desktopManager.plasma6 = lib.mkIf (config.mods.de.env == "kde") {
            enable = true;
        };

        services.desktopManager.gnome = lib.mkIf (config.mods.de.env == "gnome") {
            enable = true;
        };
    };
}
