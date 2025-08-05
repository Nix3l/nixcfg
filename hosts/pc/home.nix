{ ... }:

{
    home.stateVersion = "25.05";
    hm.mods = {
        defaults.enable = true;
        alacritty.enable = true;
        git.enable = true;

        nvim = {
            enable = true;
            discord = true;
        };

        spotify.enable = true;

        gtk = {
            enable = true;
            gruvbox.enable = true;
        };

        qt.enable = true;

        zsh.enable = true;

        wallpaper.hyprpaper = {
            enable = true;
            wallpaper = "wall.png";
        };

        cursors.capitaine.enable = true;

        hyprland = {
            enable = true;
            monitors = [
                {
                    name = "DP-1";
                    resolution = "1920x1080";
                    refreshRate = 165;
                }
            ];
        };

        sleepy.enable = true;
    };
}
