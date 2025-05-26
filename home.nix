{ pkgs, inputs, ... }:

{
    # not sure why i also need this here but who cares
    nixpkgs.config.allowUnfree = true; # allow non-FOSS

    imports = [
        inputs.nvf.homeManagerModules.default
        inputs.spicetify.homeManagerModules.spicetify
        inputs.ags.homeManagerModules.default
    ];

    # USER INFO
    home.username = "nix3l";
    home.homeDirectory = "/home/nix3l";

    # "This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes."
    home.stateVersion = "24.11";

    home.sessionVariables = {
        EDITOR = "alacritty -e nvim";
        BROWSER = "librewolf";
        EXPLORER = "thunar";
    };

    home.file = {
        # any files i want to write can go here
    };

    # GIT
    programs.git = {
        enable = true;

        userName = "nix3l";
        userEmail = "momanianas123@gmail.com";
        extraConfig = {
            init.defaultBranch = "master";
        };
    };

    # WM
    wayland.windowManager.hyprland = {
        enable = true;
        package = pkgs.hyprland;
        systemd.enable = true;
        xwayland.enable = true;

        settings = {
			# MONITOR
			monitor = [ ",preferred,auto,1" "HDMI-A-1,preferred,auto,1,mirror,eDP-1" ];

			# LOOK
			general = {
				border_size = 2;

				gaps_in = 5; # between windows
				gaps_out = 10; # between windows and montor edge

				"col.inactive_border" = "0xff928374";
				"col.active_border" = "0xffebdbb2";

				layout = "diwndle";

				resize_on_border = false;
			};

			decoration = {
				rounding = 0;

				active_opacity = 1.0;
				inactive_opacity = 0.92;

				dim_inactive = false;

				blur = {
					enabled = true;
					passes = 2;
				};

				shadow = {
					enabled = false;
				};

				# you can just add a custom shader wow
				# that is actually awesome
				# screen_shader = "";
			};

			cursor = {
				no_hardware_cursors = false;
				use_cpu_buffer = 0;
			};

			# INPUT
			"$mod" = "SUPER";

			"$terminal" = "alacritty";
			"$browser" = "librewolf";
			"$explorer" = "thunar";

			input = {
				kb_layout = "us";
				touchpad = { natural_scroll = true; };

				repeat_rate = 45;
				repeat_delay = 200;
            };

            bind = [
                "$mod, W, killactive"
                "$mod SHIFT, Q, exit"
                "$mod, S, togglefloating"
                "$mod, F, fullscreen"

                "$mod, 1, workspace, 1"
                "$mod, 2, workspace, 2"
                "$mod, 3, workspace, 3"
                "$mod, 4, workspace, 4"

                "$mod SHIFT, 1, movetoworkspace, 1"
                "$mod SHIFT, 2, movetoworkspace, 2"
                "$mod SHIFT, 3, movetoworkspace, 3"
                "$mod SHIFT, 4, movetoworkspace, 4"

                "$mod, left, movefocus, l"
                "$mod, right, movefocus, r"
                "$mod, up, movefocus, u"
                "$mod, down, movefocus, d"

                "$mod, RETURN, exec, $terminal"
                "$mod, B, exec, $browser"
                "$mod SHIFT, B, exec, $browser --private-window"
                "$mod, E, exec, $explorer"
                "$mod, G, exec, ags quit -i dashboard; ags run ~/nixcfg/ags/dashboard/app.ts --log-file ~/nixcfg/ags/dashboard/log.txt"
                # "$mod SHIFT, S, exec, gscreenshot -s -c -n -f ~/pics/screenshots/"
                "$mod SHIFT, S, exec, flameshot gui"
            ];

            binde = [
                ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%-"
                ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 5%+"
                ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle"
                ",XF86MonBrightnessUp, exec, brightnessctl set +15%"
                ",XF86MonBrightnessDown, exec, brightnessctl set 15%-"
            ];

            bindm = [
                "$mod, mouse:272, movewindow"
                "$mod, mouse:273, resizewindow"
            ];

            exec-once = [
                "ags run ~/nixcfg/ags/bar/app.ts --log-file ~/nixcfg/ags/bar/log.txt &"
                "nm-applet &"
                "fcitx5 &"
                "flameshot &"
            ];

            misc = {
                disable_hyprland_logo = true;
                disable_splash_rendering = true;
            };
        };
    };

    # WIDGETS
    programs.ags = {
        enable = true;

        extraPackages = with inputs.ags.packages.${pkgs.system}; [
            apps
            battery
            bluetooth
            hyprland
            mpris
            network
            notifd
            wireplumber
            tray
        ];
    };

    # CURSOR
    home.pointerCursor = {
        package = pkgs.capitaine-cursors;
        name = "capitaine-cursors";
        size = 32;

        gtk.enable = true;
        hyprcursor.enable = true;
        hyprcursor.size = 32;
    };

    # WALLPAPER
    services.hyprpaper = {
        enable = true;
        settings = {
            ipc = "on";
            splash = false;

            preload = [
                "~/pics/wallpapers/chinese-hills.jpg"
                "~/pics/wallpapers/ghibli-japanese-walled-garden.png"
                "~/pics/wallpapers/ign-waifu.png"
                "~/pics/wallpapers/satellites.png"
            ];

            wallpaper = [ "eDP-1,~/pics/wallpapers/satellites.png" ];
        };
    };

    # GTK & QT
    gtk = {
        enable = true;
        theme = {
            package = pkgs.gruvbox-gtk-theme;
            name = "Gruvbox-Dark";
        };

        iconTheme = {
            package = pkgs.gruvbox-dark-icons-gtk;
            name = "oomox-gruvbox-dark";
        };
    };

    qt = {
        enable = true;
        platformTheme.name = "gtk";
        style.name = "adwaita-dark";
        style.package = pkgs.adwaita-qt;
    };

    dconf = {
        enable = true;
        settings = {
            "org.gnome.desktop.interface" = {
                color-scheme = "dark";
            };
        };
    };

    # SHELL
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;

        shellAliases = {
            ls = "eza -lah --color=auto --group-directories-first";
            rebuild-system = "sudo nixos-rebuild switch --flake ~/nixcfg/#default";
            mkdir = "mkdir -p";
            rm = "rm -r";
            cp = "cp -r";
        };

        initContent = ''
            PS1="%F{#689d6a}[%B%n%b@%B%m%b]%f %F{#458588}%1~%f %B%F{#689d6a}>%f%b "
        '';
    };

    # TERMINAL
    programs.alacritty = {
        enable = true;
        package = pkgs.alacritty;
        settings = {
            terminal.shell = "zsh";
            cursor.style = "beam";

            font.normal.family = "FiraCode";
            font.size = 12;

            colors.primary = {
                background = "#282828";
                foreground = "#ebdbb2";
            };

            colors.normal = {
                black   = "#282828";
                red     = "#cc241d";
                green   = "#98971a";
                yellow  = "#d79921";
                blue    = "#458588";
                magenta = "#b16286";
                cyan    = "#689d6a";
                white   = "#a89984";
            };

            colors.bright = {
                black   = "#928374";
                red     = "#fb4934";
                green   = "#b8bb26";
                yellow  = "#fabd2f";
                blue    = "#83a598";
                magenta = "#d3869b";
                cyan    = "#8ec07c";
                white   = "#ebdbb2";
            };

            window.padding = {
                x = 8;
                y = 8;
            };
        };
    };

    # EDITOR
    programs.nvf = {
        enable = true;
        enableManpages = true;

        settings.vim = {
            viAlias = true;
            vimAlias = true;

            theme = {
                enable = true;
                name = "gruvbox";
                style = "dark";
            };

            options = {
                signcolumn = "yes";

                tabstop = 4;
                shiftwidth = 4;
                softtabstop = 0;

                mouse = "a";

                wrap = false;
            };

            statusline.lualine.enable = true;
            telescope.enable = true;
			autocomplete.nvim-cmp.enable = true;
            snippets.luasnip.enable = true;
            lsp.enable = true;

            languages = {
                enableTreesitter = true;

                clang = {
                    enable = true;
                    cHeader = true;
                };

                assembly.enable = true;
                nix.enable = true;
                ts.enable = true;
                java.enable = true;
            };

            visuals = {
                nvim-scrollbar.enable = true;
                nvim-web-devicons.enable = true;
                nvim-cursorline.enable = true;
                fidget-nvim.enable = true;
                highlight-undo.enable = true;

                # TODO(nix3l): too many tablines. clutters up the screen. should i keep this?
                indent-blankline.enable = true;
            };

            utility.oil-nvim.enable = true;

            # TODO(nix3l): do i really want this here?
            # NOTE(nix3l): for now i removed this, kinda dont need it
            # tabline.nvimBufferline.enable = true;

            presence.neocord.enable = true;

            keymaps = [
                {
                    key = "<esc>";
                    mode = "n";
                    silent = true;
                    action = ":noh<CR>";
                }
                {
                    key = "<leader>e";
                    mode = "n";
                    silent = true;
                    action = ":e .<CR>";
                }
            ];

            autocmds = [
                {
                    event = [ "BufEnter" "BufNewFile" "BufRead" ];
                    command = "setlocal filetype=glsl";
                    pattern = [ "*.comp" "*.vs" "*.fs" ];
                }
                {
                    event = [ "BufEnter" "BufNewFile" "BufRead" ];
                    command = "setlocal filetype=c";
                    pattern = [ "*.c" "*.h" ];
                }
            ];
        };
    };

    # SPOTFIY
    programs.spicetify = let
        spicepkgs = inputs.spicetify.legacyPackages.${pkgs.stdenv.system};
    in {
        enable = true;
        enabledExtensions = with spicepkgs.extensions; [
            adblockify
            hidePodcasts
            fullAlbumDate
            volumePercentage
			fullScreen
        ];

        theme = spicepkgs.themes.text;
        colorScheme = "Gruvbox";
    };

    # WHATEVER THIS IS
    xdg = {
        enable = true;
        portal = {
            enable = true;
            extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
            config.common.default = [ "gtk" ];
        };
    };

    # let home manager install and manage itself
    programs.home-manager.enable = true;
}
