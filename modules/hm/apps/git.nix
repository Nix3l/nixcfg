{ lib, config, osConfig, ... }:

{
    options.hm.mods.git = with lib; {
        enable = mkEnableOption "git";
    };

    config = lib.mkIf config.hm.mods.git.enable {
        programs.git = {
            enable = true;
            settings = {
                user = {
                    name = osConfig.mods.mainUser.name;
                    email = osConfig.mods.mainUser.email;
                };

                init.defaultBranch = "master";
            };
        };
    };
}
