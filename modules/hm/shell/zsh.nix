{ lib, config, osConfig, ... }:

{
    options.hm.mods.zsh = with lib; {
        enable = mkEnableOption "zsh";
        completion = mkOption { default = true; };
        highlighting = mkOption { default = true; };
    };

    config = lib.mkIf config.hm.mods.zsh.enable {
        programs.zsh = {
            enable = true;
            enableCompletion = config.hm.mods.zsh.completion;
            syntaxHighlighting.enable = config.hm.mods.zsh.highlighting;

            shellAliases = {
                ls = "eza -lah --color=auto --group-directories-first";
                mkdir = "mkdir -p";
                rm = "rm -r";
                cp = "cp -r";
                arduino-wayland = if osConfig.mods.dev.arduino.enable then "arduino-ide --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-gpu" else "";
            };

            initContent = ''
                PS1="%F{#689d6a}[%B%n%b@%B%m%b]%f %F{#458588}%1~%f %B%F{#689d6a}>%f%b "
            '';
        };
    };
}
