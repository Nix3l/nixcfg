{ lib, config, pkgs, ... }:

let
  cfg = config.mods.dev.xampp;
in
{
  options.mods.dev.xampp = with lib; {
    enable = mkEnableOption "xampp";

    documentRoot = mkOption {
      type = types.str;
      default = "/var/www/xampp";
    };

    hostName = mkOption {
      type = types.str;
      default = "localhost";
    };

    withMysql = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = lib.mkIf cfg.enable {
    mods.dev.mysql.enable = cfg.withMysql;

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

