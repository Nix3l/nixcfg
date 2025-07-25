{ lib, config, pkgs, ... }:

{
    options.mods.dev.java = with lib; {
        enable = mkEnableOption "java devtools";
        jetbrains.enable = mkEnableOption "jetbrains idea community";
        eclipse.enable = mkEnableOption "eclipse";
    };

    config = lib.mkIf config.mods.dev.java.enable {
        programs.java.enable = true;
        environment.systemPackages = with pkgs; [
            (lib.optional config.mods.dev.java.eclipse.enable eclipses.eclipse-java)
            (lib.optional config.mods.dev.java.jetbrains.enable jetbrains.idea-community)
        ];
    };
}
