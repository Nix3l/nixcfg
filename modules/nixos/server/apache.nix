{ lib, config, pkgs, ... }:

let
    cfg = config.mods.server.apache;
in
{
    options.mods.server.apache = with lib; {
        enable = mkEnableOption "apache";

        documentRoot = mkOption {
            type = types.str;
            default = "/var/www/xampp";
        };

        hostName = mkOption {
            type = types.str;
            default = "localhost";
        };

        withMySQL = mkOption {
            type = types.bool;
            default = true;
        };
    };

    config = lib.mkIf cfg.enable {
        mods.dev.mysql.enable = cfg.withMySQL;

        services = {
            httpd = {
                enable = true;
                enablePHP = true;

                virtualHosts.${cfg.hostName} = {
                    documentRoot = cfg.documentRoot;
                };
            };
        };

        networking.firewall.allowedTCPPorts = [ 80 ];

        environment.systemPackages = with pkgs; [ php phpPackages.composer ];
    };
}

