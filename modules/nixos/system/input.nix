{ lib, config, pkgs, ... }:

{
    options.mods.input.ime = {
        enable = lib.mkEnableOption "ime";
        jp = lib.mkEnableOption "jp input";
    };

    config = lib.mkIf config.mods.input.ime.enable {
        i18n.inputMethod = {
            enable = true;
            type = "fcitx5";
            fcitx5 = {
                addons = lib.lists.flatten (with pkgs; [
                    (lib.optional config.mods.input.ime.jp fcitx5-mozc)
                    fcitx5-gtk
                ]);

                waylandFrontend = true;
            };
        };

        environment.sessionVariables = {
            QT_IM_MODULE = "fcitx";
            QT_IM_MODULES = "wayland;fcitx";
            XMODIFIERS = "@im=fcitx";
            XMODIFIER = "@im=fcitx";
        };
    };
}
