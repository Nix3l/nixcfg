{ ... }:

{
    home.stateVersion = "25.05";
    hm.mods = {
        session.enable = true;

        alacritty = {
            enable = true;
            font = "Tamzen";
        };

        zsh.enable = true;

        git.enable = true;

        dev = {
            nvim = {
                enable = true;
                discord = true;
            };

            vscode.enable = true;
        };

        spotify.enable = true;

        gtk = {
            enable = true;
            gruvbox.enable = true;
        };

        qt.enable = true;

        wallpaper.hyprpaper = {
            enable = true;
            wallpaper = "magma_gruvbox.png";
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

        sleepy = {
            enable = true;
            pfp = {
                enable = true;
                format = "png";
            };
        };
    };
}
