{ lib, config, pkgs, ... }:

{
    options.mods.dev.java = with lib; {
        enable = mkEnableOption "java devtools";
        jetbrains.enable = mkEnableOption "jetbrains idea community";
    };

    config = lib.mkIf config.mods.dev.java.enable {
        programs.java.enable = true;
        environment.systemPackages = with pkgs; [ eclipses.eclipse-java ];
    };
}
