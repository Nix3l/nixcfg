{ inputs, lib, config, ... }:

{
    options.mods.mainUser = {
        name = lib.mkOption { type = lib.types.str; };
        groups = lib.mkOption {
            type = with lib.types; listOf nonEmptyStr;
            default = [ "networkmanager" "wheel" ];
        };

        email = lib.mkOption { type = lib.types.str; };

        homeManager.enable = lib.mkEnableOption "home manager";
        homeManager.module = lib.mkOption { type = lib.types.path; };
    };

    config = {
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
