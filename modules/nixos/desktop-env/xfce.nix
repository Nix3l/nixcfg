{ lib, config, pkgs, ... }:

{
    options.mods.desktopenv.xfce = with lib; {
        enable = mkEnableOption "xfce";
    };

    config = lib.mkIf config.mods.desktopenv.xfce.enable {
        services = {
            xserver = {
                enable = true;
                autorun = false;

                desktopManager = {
                    xfce.enable = true;
                };

                displayManager = {
                    lightdm.enable = true;
                };
            };

            libinput.enable = true;
            gnome.gnome-keyring.enable = true;
        };

        security.pam.services.gdm.enableGnomeKeyring = true;
        environment.systemPackages = with pkgs; [
            gnome-keyring
            xfce.xfwm4-themes
            xfce.thunar
            xfce.thunar-volman
            xfce.xfce4-appfinder
            xfce.xfce4-clipman-plugin
            xfce.xfce4-cpugraph-plugin
            xfce.xfce4-eyes-plugin
            xfce.xfce4-whiskermenu-plugin
            xfce.xfce4-weather-plugin
            xfce.xfce4-mailwatch-plugin
            xfce.xfce4-netload-plugin
            xfce.xfce4-notes-plugin
            xfce.xfce4-notifyd
            xfce.xfce4-power-manager
            xfce.xfce4-pulseaudio-plugin
            xfce.xfce4-screensaver
            xfce.xfce4-screenshooter
            xfce.xfce4-session
            xfce.xfce4-settings
            xfce.xfce4-systemload-plugin
            xfce.xfce4-taskmanager
            xfce.xfce4-terminal
            xfce.xfce4-verve-plugin
        ];

        programs.xfconf.enable = true;
    };
}
