{ inputs, lib, config, ... }:

{
    options.mods.mainUser = with lib; {
        name = lib.mkOption {
            type = with types; nullOr str;
            default = null;
        };

        groups = lib.mkOption {
            type = with types; listOf nonEmptyStr;
            default = [ "networkmanager" "wheel" ];
        };

        email = lib.mkOption { type = types.str; };

        homeManager.enable = lib.mkEnableOption "home manager";
        homeManager.module = lib.mkOption { type = types.path; };
    };

    config = lib.mkIf (builtins.isString config.mods.mainUser.name) {
        users.users.${config.mods.mainUser.name} = {
            isNormalUser = true;
            description = config.mods.mainUser.name;
            extraGroups = config.mods.mainUser.groups;
        };

        home-manager.extraSpecialArgs = { inherit inputs; };
        home-manager.users."${config.mods.mainUser.name}" = lib.mkIf config.mods.mainUser.homeManager.enable {
            imports = [
                config.mods.mainUser.homeManager.module
                inputs.self.outputs.hm-modules.default
            ];
        };
    };
}
