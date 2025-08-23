{ inputs, pkgs, ... }:

{
    imports = [
        # flakes
        inputs.copyparty.nixosModules.default

        # modules
        ./apps/desktop-apps.nix
        ./apps/electron.nix
        ./apps/extra.nix
        ./apps/media.nix
        ./apps/minecraft.nix
        ./apps/steam.nix
        ./apps/terminal-apps.nix
        ./apps/util.nix
        ./apps/wine.nix
        ./desktop-env/de.nix
        ./dev/arduino.nix
        ./dev/java.nix
        ./kernel-modules/ddcci.nix
        ./locale/en.nix
        ./locale/jp.nix
        ./server/copyparty.nix
        ./system/audio.nix
        ./system/fonts.nix
        ./system/input.nix
        ./system/laptop-lid.nix
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
