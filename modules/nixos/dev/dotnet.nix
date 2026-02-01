{ lib, config, pkgs, ... }:

let
    cfg = config.mods.dev.dotnet;
in
{
    options.mods.dev.dotnet = with lib; {
        enable = mkEnableOption "dotnet";
        sdk = mkOption { default = pkgs.dotnet-sdk_10; };
        runtime = mkOption { default = pkgs.dotnet-runtime_10; };
    };

    config = lib.mkIf cfg.enable {
        environment.systemPackages = [ cfg.sdk cfg.runtime ];
        environment.sessionVariables = {
            DOTNET_ROOT = "${cfg.sdk}/share/dotnet";
        };
    };
}
