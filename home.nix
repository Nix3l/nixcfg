{ pkgs, inputs, lib, ... }:

{
    # not sure why i also need this here but who cares
    nixpkgs.config.allowUnfree = true; # allow non-FOSS

    imports = [
        inputs.nixvim.homeManagerModules.nixvim
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

        initExtra = ''
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
    programs.nixvim = {
        enable = true;
		enableMan = true; # installs man page

        colorschemes.gruvbox.enable = true;
        plugins.lualine.enable = true;

        plugins.treesitter = {
			enable = true;
			autoLoad = true;
		};

        plugins.lsp = {
            enable = true;
            servers = {
                ccls.enable = true;
                nixd.enable = true;
                ts_ls.enable = true;
                jdtls.enable = true;
            };

            keymaps.lspBuf = {
                "gd" = "definition";
                "gr" = "references";
                "gy" = "type_definition";
                "gi" = "implementation";
                "K" = "hover";
            };
        };

        # FIXME
        plugins.cmp = {
            enable = true;
            autoEnableSources = true;
			autoLoad = true;
        };

		plugins.nvim-jdtls = {
			enable = true;
			cmd = [
				(lib.getExe pkgs.jdt-language-server)
				"-data" "/home/nix3l/uni/temp/programming"
				# "-configuration" "/path/to/your/configuration"
			];
		};
 
        plugins.web-devicons.enable = true;
        plugins.nvim-tree = {
            enable = true;
            openOnSetupFile = true;
            autoReloadOnWrite = true;
        };

        globalOpts = {
            signcolumn = "yes";

            tabstop = 4;
            shiftwidth = 4;
            softtabstop = 0;
            expandtab = true;
            smarttab = true;
			autoindent = true;

            mouse = "a";

            number = true;
            relativenumber = true;

            undofile = true;

            encoding = "utf-8";
            fileencoding = "utf-8";

            ruler = true;

            splitbelow = true;
            splitright = true;

			updatetime = 100;

			hidden = false;
			autoread = true;

			termguicolors = true;

			hlsearch = true;
			incsearch = true;
        };

        extraConfigVim = ''
            set number
            set relativenumber
            set shiftwidth=4
			set tabstop=4
			let g:gruvbox_contrast_dark='hard'
			let g:gruvbox_contrast_light='hard'
			hi LspCxxHlGroupMemberVariable guifg=#83a598
        '';

        keymaps = [
            {
                key = "<esc>";
                action = ":noh<CR>";
				options.silent = true;
            } {
                key = "<Space>e";
                action = ":NvimTreeToggle<CR>";
				options.silent = true;
            }
        ];

        autoCmd = [
			{
                event = [ "BufEnter" "BufNewFile" "BufRead" ];
                command = "set shiftwidth=4 tabstop=4";
                pattern = [ "*" ];
            } {
                event = [ "BufEnter" "BufNewFile" "BufRead" ];
                command = "setlocal filetype=c";
                pattern = [ "*.h" ];
            } {
                event = [ "BufEnter" "BufNewFile" "BufRead" ];
                command = "setlocal filetype=glsl";
                pattern = [ "*.comp" "*.vs" "*.fs" ];
            }
        ];
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
        colorScheme = "gruvbox";
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
