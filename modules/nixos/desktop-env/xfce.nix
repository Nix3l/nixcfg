{ lib, config, ... }:

{
    options.mods.desktopenv.xfce = with lib; {
        enable = mkEnableOption "xfce";
    };

    config = lib.mkIf config.mods.desktopenv.xfce.enable {
        services.xserver = {
            enable = true;
            autorun = false;
            layout = "us";
            xkbVariant = "";
            libinput.enable = true;

            desktopManager = {
                xfce.enable = true;
                xfce.enableXfwm = true;
            };

            displayManager = {
                startx = {
                    enable = true;
                    generateScript = true;
                };

                defaultSession = "xfce";
            };
        };
    };
}
