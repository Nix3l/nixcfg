{ lib, config, inputs, ... }:

{
    options.mods.server.copyparty = with lib; {
        enable = mkEnableOption "copyparty service";
    };

    config = lib.mkIf config.mods.server.copyparty.enable {
        nixpkgs.overlays = [ inputs.copyparty.overlays.default ];

        systemd.tmpfiles.rules = [
            "d /run/keys/copyparty 0755 copyparty copyparty -"
            "d /srv/copyparty 0755 copyparty copyparty -"
            "f /srv/copyparty/nix3l_password 0644 copyparty copyparty -"
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
                        rw = [ "nix3l" ];
                    };
                };
            };
        };
    };
}
