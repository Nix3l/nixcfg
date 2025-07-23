{ lib, config, ... }:

{
    options.hm.mods.cursor = with lib; {
        enable = mkEnableOption "cursor theme";
        name = mkOption { type = types.str; };
        pkg = mkOption { type = types.package; };
        size = mkOption { type = types.int; };
    };

    config = lib.mkIf config.hm.mods.cursor.enable {
        home.pointerCursor = with config.hm.mods; {
            package = cursor.pkg;
            name = cursor.name;
            size = cursor.size;

            gtk.enable = gtk.enable;
            hyprcursor = lib.mkIf hyprland.enable {
                enable = true;
                size = cursor.size;
            };
        };
    };
}
