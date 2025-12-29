{ ... }:

{
    home.stateVersion = "25.05";
    hm.mods = {
        session.enable = true;

        kitty.enable = true;
        fish.enable = true;

        git.enable = true;

        dev = {
            nvim = {
                enable = true;
                discord = true;
            };

            vscode.enable = true;
        };

        spotify.enable = true;

        audio.effects = {
            enable = true;
            preset = "mic-noise-remover";
        };

        gtk = {
            enable = true;
            gruvbox.enable = true;
        };

        qt.enable = true;

        wallpaper.hyprpaper = {
            enable = true;
            wallpaper = "rockman.png";
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
