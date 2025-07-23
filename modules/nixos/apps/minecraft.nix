{ lib, config, inputs, pkgs, ... }:

{
    options.mods.apps.minecraft = with lib; {
        enable = mkEnableOption "polymc minecraft launcher";
    };

    config = lib.mkIf config.mods.apps.minecraft.enable {
        nixpkgs.overlays = [ inputs.polymc.overlay ];
        environment.systemPackages = with pkgs; [ polymc ];
    };
}
