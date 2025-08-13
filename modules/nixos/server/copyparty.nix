{ lib, config, inputs, pkgs, ... }:

{
    options.mods.server.copyparty = with lib; {
        enable = mkEnableOption "copyparty service";
    };

    config = lib.mkIf config.mods.server.copyparty.enable {
        nixpkgs.overlays = [ inputs.copyparty.overlays.default ];
        environment.systemPackages = [ pkgs.copyparty ];

        systemd.tmpfiles.rules = [
            "d /run/keys/copyparty 0755 copyparty copyparty -"
            "d /srv/copyparty 0755 copyparty copyparty -"
            "f /run/keys/copyparty/nix3l_password 0644 copyparty copyparty -"
        ];

        services.copyparty = {
            enable = true;

            accounts = {
                nix3l.passwordFile = "/run/keys/copyparty/nix3l_password";
            };

            volumes = {
                "/" = {
                    path = "/srv/copyparty";
                    access = {
                        A = [ "nix3l" ];
                    };
                };
            };
        };

        networking.firewall = {
            allowedTCPPorts = [ 3923 ];
            allowedTCPPortRanges = [
                { from = 12000; to = 12099; }
            ];
        };
    };
}
