{ inputs, lib, config, ... }:

let
    cfg = config.hm.mods.zen;
in
{
    imports = [ inputs.zen-browser.homeModules.beta ];

    options.hm.mods.zen = with lib; {
        enable = mkEnableOption "zen browser";
        default = mkOption { default = true; };
    };

    config = lib.mkIf cfg.enable {
        programs.zen-browser = {
            enable = true;
            setAsDefaultBrowser = cfg.default;
        };
    };
}
