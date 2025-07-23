{ pkgs, ... }:

{
    imports = [
        ./apps/desktop-apps.nix
        ./apps/electron.nix
        ./apps/extra.nix
        ./apps/media.nix
        ./apps/minecraft.nix
        ./apps/steam.nix
        ./apps/terminal-apps.nix
        ./apps/util.nix
        ./apps/wine.nix
        ./de/de.nix
        ./locale/en.nix
        ./locale/jp.nix
        ./system/audio.nix
        ./system/fonts.nix
        ./system/input.nix
        ./system/ld.nix
        ./system/networking.nix
        ./system/nvidia.nix
        ./system/services.nix
        ./user/main-user.nix
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;
    time.timeZone = "Asia/Amman";

    environment.systemPackages = with pkgs; [
        git
    ];
}
