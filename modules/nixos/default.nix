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
        ./desktopenv/de.nix
        ./dev/java.nix
        ./kernelmodules/ddcci.nix
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

    nixpkgs.config.permittedInsecurePackages = [
        # temporary until its fixed
        "libxml2-2.13.8"
    ];
}
