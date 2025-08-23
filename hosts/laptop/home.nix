{ ... }:

{
    home.stateVersion = "25.05";
    hm.mods = {
        defaults.enable = true;
        alacritty = {
            enable = true;
            font = "Tamzen";
        };

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
            monitor = "eDP-1";
        };

        cursors.capitaine.enable = true;

        hyprland = {
            enable = true;
            monitors = [
                {
                    name = "eDP-1";
                    resolution = "1920x1080";
                    refreshRate = 144;
                }
            ];
        };

        sleepy = {
            enable = true;
            cfg = {
                modules.bluetoothStatus.enable = true;
            };

            pfp = {
                enable = true;
                format = "png";
            };
        };
    };
}
