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

        zsh.enable = true;

        wallpaper.hyprpaper = {
            enable = true;
            wallpaper = "my-neighbor-totoro-sunflowers.png";
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
                {
                    name = "HDMI-A-1";
                    resolution = "1920x1080";
                    refreshRate = 60;
                    mirror = {
                        enable = true;
                        from = "eDP-1";
                    };
                }
            ];
        };

        sleepy = {
            enable = true;
            cfg = {
                modules = {
                    bluetoothStatus = true;
                    powerStatus = true;
                };
            };

            pfp = {
                enable = true;
                format = "jpeg";
            };
        };
    };
}
