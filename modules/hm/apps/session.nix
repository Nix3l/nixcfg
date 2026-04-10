{ lib, config, osConfig, ... }:

let
    cfg = config.hm.mods.session;
in
{
    options.hm.mods.session = with lib; {
        enable = mkEnableOption "session env variables";

        terminal    = mkOption { default = "kitty"; };
        shell       = mkOption { default = "bash"; };
        browser     = mkOption { default = "librewolf"; };
        explorer    = mkOption { default = "dolphin"; };
        editor      = mkOption { default = "nvim"; };
        mediaPlayer = mkOption { default = "mpv"; };
        imageViewer = mkOption { default = "nsxiv"; };
    };

    config = lib.mkIf cfg.enable {
        home.sessionVariables = with cfg; {
            # in case these are set from some other modules
            TERMINAL     = lib.mkOverride 0 terminal;
            SHELL        = lib.mkOverride 0 shell;
            BROWSER      = lib.mkOverride 0 browser;
            EXPLORER     = lib.mkOverride 0 explorer;
            EDITOR       = lib.mkOverride 0 editor;
            MEDIA_PLAYER = lib.mkOverride 0 mediaPlayer;
            IMAGE_VIEWER = lib.mkOverride 0 imageViewer;
        };
    };
}
