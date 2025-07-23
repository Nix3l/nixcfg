{ lib, config, osConfig, ... }:

{
    options.hm.mods.git = with lib; {
        enable = mkEnableOption "git";
    };

    config = lib.mkIf config.hm.mods.git.enable {
        programs.git = {
            enable = true;
            userName = osConfig.mods.mainUser.name;
            userEmail = osConfig.mods.mainUser.email;
            extraConfig = {
                init.defaultBranch = "master";
            };
        };
    };
}
