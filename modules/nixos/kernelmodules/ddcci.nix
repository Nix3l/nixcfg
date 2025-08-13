{ lib, config, pkgs, ... }:

{
    options.mods.kernel.ddcci = with lib; {
        enable = mkEnableOption "ddcci kernel module";
    };

    config = lib.mkIf config.mods.kernel.ddcci.enable {
        # no clue what any of this does but hey, if it works
        boot.extraModulePackages = [ config.boot.kernelPackages.ddcci-driver ];
        boot.kernelModules = [ "i2c-dev" "ddcci_backlight" ];
        hardware.i2c.enable = true;

        # currently only works with nvidia cards but who cares
        services.udev.extraRules = ''                                                                                                                                               
            SUBSYSTEM=="i2c-dev", ACTION=="add",\
            ATTR{name}=="NVIDIA i2c adapter*",\
            TAG+="ddcci",\
            TAG+="systemd",\
            ENV{SYSTEMD_WANTS}+="ddcci@$kernel.service"
        '';

        systemd.services."ddcci@" = {
            scriptArgs = "%i";
            script = ''
                echo Trying to attach ddcci to $1
                i=0
                id=$(echo $1 | cut -d "-" -f 2)
                if ${pkgs.ddcutil}/bin/ddcutil getvcp 10 -b $id; then
                  echo ddcci 0x37 > /sys/bus/i2c/devices/$1/new_device
                fi
            '';
            serviceConfig.Type = "oneshot";
        };
    };
}
