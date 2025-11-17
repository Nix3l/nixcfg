{ lib, config, ... }:

{
    options.hm.mods.dev.vscode = with lib; {
        enable = mkEnableOption "vscode";
    };

    config = lib.mkIf config.hm.mods.dev.vscode.enable {
        programs.vscode.enable = true;
    };
}
