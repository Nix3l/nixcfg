{ lib, config, ... }:

{
    options.mods.extraPackages = with lib; mkOption {
        type = with types; listOf package;
        default = [];
    };

    config = {
        environment.systemPackages = config.mods.extraPackages;
    };
}
