{ lib, config, ... }:

let
    cfg = config.hm.mods.session;
in
{
    options.hm.mods.session = with lib; {
        enable = mkEnableOption "session env variables";

        terminal    = mkOption { default = "kitty"; };
        shell       = mkOption { default = "bash"; };
        browser     = mkOption { default = "librewolf"; };
        explorer    = mkOption { default = "thunar"; };
        editor      = mkOption { default = "nvim"; };
        mediaPlayer = mkOption { default = "mpv"; };
        imageViewer = mkOption { default = "nsxiv"; };
    };

    config = lib.mkIf cfg.enable {
        home.sessionVariables = with cfg; {
            TERMINAL = terminal;
            SHELL = shell;
            BROWSER = browser;
            EXPLORER = explorer;
            EDITOR = editor;
            MEDIA_PLAYER = mediaPlayer;
            IMAGE_VIEWER = imageViewer;
        };
    };
}
