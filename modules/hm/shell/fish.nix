{ lib, config, osConfig, ... }:

let
    cfg = config.hm.mods.fish;
in
{
    options.hm.mods.fish = with lib; {
        enable = mkEnableOption "fish";
    };

    config = lib.mkIf cfg.enable {
        programs.fish = {
            enable = true;

            preferAbbrs = true;
            shellAbbrs = {
                ls = "eza -lah --color=auto --group-directories-first";
                mkdir = "mkdir -p";
                rm = "rm -r";
                cp = "cp -r";
                cat = "cat -v";
                arduino-wayland = lib.mkIf osConfig.mods.dev.arduino.enable "arduino-ide --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-gpu";
            };
        };

        hm.mods.session.shell = lib.mkForce "fish";
    };
}
