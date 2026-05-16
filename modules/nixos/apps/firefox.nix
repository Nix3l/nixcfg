{ lib, config, pkgs, ... }:

let
    cfg = config.mods.apps.firefox;
in
{
    options.mods.apps.firefox = with lib; {
        enable = mkEnableOption "firefox";
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = [ pkgs.firefoxpwa ];

        programs.firefox = {
            enable = true;
            package = pkgs.firefox;
            nativeMessagingHosts.packages = [ pkgs.firefoxpwa ];
        };
    };
}
