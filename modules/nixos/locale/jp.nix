{ lib, config, ... }:

{
    options.mods.locale = {
        jp = lib.mkEnableOption "japanese locale";
    };

    config = lib.mkIf config.mods.locale.jp {
        i18n.defaultLocale = "ja_JP.UTF-8";
        i18n.extraLocaleSettings = {
            LC_ADDRESS = "ja_JP.UTF-8";
            LC_IDENTIFICATION = "ja_JP.UTF-8";
            LC_MEASUREMENT = "ja_JP.UTF-8";
            LC_MONETARY = "ja_JP.UTF-8";
            LC_NAME = "ja_JP.UTF-8";
            LC_NUMERIC = "ja_JP.UTF-8";
            LC_PAPER = "ja_JP.UTF-8";
            LC_TELEPHONE = "ja_JP.UTF-8";
            LC_TIME = "ja_JP.UTF-8";
        };
    };
}
