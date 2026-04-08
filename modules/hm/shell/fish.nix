{ lib, config, osConfig, pkgs, ... }:

let
    cfg = config.hm.mods.fish;
in
{
    options.hm.mods.fish = with lib; {
        enable = mkEnableOption "fish";
    };

    config = lib.mkIf cfg.enable {
        programs.fish = {
            enable = true;

            plugins = [
                {
                    name = "gruvbox";
                    src = pkgs.fetchFromGitHub {
                        owner = "Jomik";
                        repo = "fish-gruvbox";
                        rev = "80a6f3a7b31beb6f087b0c56cbf3470204759d1c";
                        sha256 = "sha256-vL2/Nm9Z9cdaptx8sJqbX5AnRtfd68x4ZKWdQk5Cngo=";
                    };
                }
            ];

            interactiveShellInit = ''
                function fish_greeting
                    # todo
                end

                theme_gruvbox dark
            '';

            preferAbbrs = true;
            shellAbbrs = {
                ls = "eza -lah --color=auto --group-directories-first";
                mkdir = "mkdir -p";
                rm = "rm -r";
                cp = "cp -r";
                cat = "cat -v";
                arduino-wayland = lib.mkIf osConfig.mods.dev.arduino.enable "arduino-ide --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-gpu";
            };
        };

        hm.mods.session.shell = lib.mkForce "fish";
    };
}
