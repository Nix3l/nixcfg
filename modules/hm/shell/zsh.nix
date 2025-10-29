{ lib, config, osConfig, ... }:

let
    cfg = config.hm.mods.zsh;
in
{
    options.hm.mods.zsh = with lib; {
        enable = mkEnableOption "zsh";
        completion = mkOption { default = true; };
        highlighting = mkOption { default = true; };
    };

    config = lib.mkIf cfg.enable {
        programs.zsh = {
            enable = true;
            enableCompletion = cfg.completion;
            syntaxHighlighting.enable = cfg.highlighting;

            shellAliases = {
                ls = "eza -lah --color=auto --group-directories-first";
                mkdir = "mkdir -p";
                rm = "rm -r";
                cp = "cp -r";
                cat = "cat -v";
                arduino-wayland = lib.mkIf osConfig.mods.dev.arduino.enable "arduino-ide --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-gpu";
            };

            initContent = ''
                PS1="%F{#689d6a}[%B%n%b@%B%m%b]%f %F{#458588}%1~%f %B%F{#689d6a}>%f%b "
            '';
        };
    };
}
