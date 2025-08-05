{ inputs, osConfig, ... }:

{
    # not sure why i also need this here but who cares
    nixpkgs.config.allowUnfree = true; # allow non-FOSS

    imports = [
        # flakes
        inputs.nvf.homeManagerModules.default
        inputs.spicetify.homeManagerModules.spicetify

        # modules
        ./apps/alacritty.nix
        ./apps/defaults.nix
        ./apps/git.nix
        ./apps/nvim.nix
        ./apps/spotify.nix
        ./cursor/cursor.nix
        ./cursor/capitaine.nix
        ./gtk/gtk.nix
        ./gtk/gruvbox.nix
        ./qt/qt.nix
        ./quickshell/sleepy.nix
        ./shell/zsh.nix
        ./wallpaper/hyprpaper.nix
        ./wm/hyprland.nix
    ];

    home = {
        username = "${osConfig.mods.mainUser.name}";
        homeDirectory = "/home/${osConfig.mods.mainUser.name}";
    };

    # let home manager install and manage itself
    programs.home-manager.enable = true;
}
