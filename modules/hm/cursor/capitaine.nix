{ lib, config, pkgs, ... }:

{
    options.hm.mods.cursors.capitaine = with lib; {
        enable = mkEnableOption "capitaine cursor theme";
        size = mkOption {
            type = types.int;
            default = 32;
        };
    };

    config = lib.mkIf config.hm.mods.cursors.capitaine.enable {
        home.packages = [ pkgs.capitaine-cursors ];
        hm.mods.cursor = lib.mkForce {
            enable = true;
            name = "capitaine-cursors";
            pkg = pkgs.capitaine-cursors;
            size = config.hm.mods.cursors.capitaine.size;
        };
    };
}
