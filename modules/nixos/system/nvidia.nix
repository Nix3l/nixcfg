{ lib, config, ... }:

{
    options.mods.nvidia = {
        enable = lib.mkEnableOption "use the open-source nvidia drivers";
    };

    config = lib.mkIf config.mods.nvidia.enable {
        services.xserver.videoDrivers = [ "nvidia" "intel" ];
        hardware = {
            graphics.enable = true;
            nvidia = {
                modesetting.enable = true; # required
                open = true; # use open source kernel modules
                nvidiaSettings = true; # enable settings menu (via nvidia-settings)
                package = config.boot.kernelPackages.nvidiaPackages.stable; # use the latest stable build
            };
        };
    };
}
