{ lib, config, ... }:

{
    options.mods.laptop.lid = with lib; {
        disableSleepOnClose = mkEnableOption "remove sleeping on lid close";
    };

    config = lib.mkIf config.mods.laptop.lid.disableSleepOnClose {
        services.logind = {
            lidSwitch = "ignore";
            lidSwitchExternalPower = "ignore";
            lidSwitchDocked = "ignore";
        };
    };
}
