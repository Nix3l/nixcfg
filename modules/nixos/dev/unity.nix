{ lib, config, pkgs, ... }:

let
    cfg = config.mods.dev.unity;
in
{
    options.mods.dev.unity = with lib; {
        enable = mkEnableOption "unityhub";
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [ unityhub ];
    };
}
