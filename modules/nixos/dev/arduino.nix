{ lib, config, pkgs, ... }:

{
    options.mods.dev.arduino = with lib; {
        enable = mkEnableOption "arduino dev tools";
    };

    config = lib.mkIf config.mods.dev.arduino.enable {
        environment.systemPackages = with pkgs; [
            arduino-core
            arduino-ide
        ];
    };
}
