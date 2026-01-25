{ lib, config, pkgs, ... }:

let
    cfg = config.mods.dev.mysql;
in
{
    options.mods.dev.mysql = with lib; {
        enable = mkEnableOption "sql";       
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [ mysql-workbench mycli ];
        services = {
            mysql = {
                enable = true;
                package = pkgs.mariadb;

            };

            gnome.gnome-keyring.enable = true;
        };
    };
}
