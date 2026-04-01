{ lib, config, pkgs, ... }:

let
    cfg = config.mods.dm.sddm;

    pixie-pkg = ../../../pkgs/pixie.nix;
    astronaut-pkg = pkgs.sddm-astronaut.override {
        embeddedTheme = "pixel_sakura";
    };

    theme-name = (if cfg.theme == "astronaut" then "sddm-astronaut-theme" else cfg.theme);
in
{
    options.mods.dm.sddm = with lib; {
        enable = mkEnableOption "sddm";
        theme = mkOption {
            type = with types; enum [
                "pixie"
                "astronaut"
            ];

            default = "astronaut";
        };
    };

    config = lib.mkIf cfg.enable {
        systemd.services.display-manager.enable = true;
        services.displayManager.sddm = {
            enable = true;
            package = pkgs.kdePackages.sddm;
            wayland.enable = true;
            theme = theme-name;

            extraPackages = []
                ++ (lib.optional (cfg.theme == "astronaut") astronaut-pkg);

            settings = {
                Theme = {
                    Current = theme-name;
                    CursorTheme = "capitaine-cursors";
                    CursorSize = 32;
                };
            };
        };

        # taken from https://github.com/thomX75/nixos-modules/blob/main/SDDM/sddm-avatar.nix
        # needed so proper pfp loads in sddm
        # modified slightly to always replace the file on every boot because their solution doesnt work and im not smart enough to fix it
        systemd.services."sddm-avatar" = {
            description = "Service to copy or update users Avatars at startup.";
            wantedBy = [ "multi-user.target" ];
            before = [ "sddm.service" ];
            script = ''
                for user in /home/*; do
                    username=$(basename "$user")
                    icon_source="$user/.face.icon"
                    icon_dest="/var/lib/AccountsService/icons/$username"

                    if [ -f "$icon_source" ]; then
                        rm -f "$icon_dest"
                        cp -L "$icon_source" "$icon_dest"
                    fi
                done
            '';

            serviceConfig = {
                Type = "simple";
                User = "root";
                StandardOutput = "journal+console";
                StandardError = "journal+console";
            };
        };

        # ensures sddm starts after copying the avatar
        systemd.services.sddm = {
            after = [ "sddm-avatar.service" ];
        };

        environment.systemPackages = with pkgs; [ capitaine-cursors ]
            ++ (lib.optional (cfg.theme == "pixie") (pkgs.callPackage pixie-pkg {}))
            ++ (lib.optional (cfg.theme == "astronaut") astronaut-pkg);
    };
}
