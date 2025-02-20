{ config, pkgs, ... }:

{
  # USER INFO
  home.username = "nix3l";
  home.homeDirectory = "/home/nix3l";

  # "This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes."
  home.stateVersion = "24.11";

  home.sessionVariables = {
     EDITOR = "alacritty -e nvim";
     BROWSER = "librewolf";
     EXPLORER = "thunar";
  };

  home.packages = [
    # any packages i want installed can go here
  ];

  home.file = {
    # any files i want to write can go here
  };

  # GIT
  programs.git = {
    enable = true;
    package = pkgs.git;

    userName  = "nix3l";
    userEmail = "momanianas123@gmail.com";
  };

  # WM
  wayland.windowManager.hyprland = {
     enable = true;
     package = pkgs.hyprland;
     systemd.enable = true;

     settings = {
	# MONITOR
     	monitor = ",preferred,auto,1";

	# LOOK
	general = {
	  border_size = 2;

	  gaps_in = 5; # between windows
	  gaps_out = 20; # between windows and montor edge

	  "col.inactive_border" = "0xff444444";
	  "col.active_border" = "0xffffffff";

	  layout = "diwndle";

	  resize_on_border = false;
	};

	decoration = {
	  rounding = 0;

	  active_opacity = 1.0;
	  inactive_opactiy = 0.9;

	  dim_inactive = false;

	  # you can just add a custom shader wow
	  # that is actually awesome
	  # screen_shader = "";

	  blur = {
	    enabled = false;
	  };

	  shadow = {
	    enabled = false;
	  };
	};

	# INPUT
	"$mod" = "SUPER";
	
	"$terminal" = "alacritty";
	"$browser" = "librewolf";
	"$explorer" = "thunar";
	
	input = {
	  kb_layout = "us";
	  touchpad = { natural_scroll = true; };
	};

	bind = [
	  "$mod, W, killactive"
	  "$mod SHIFT, W, exit"
	  "$mod, T, togglefloating"
	  # "$mod, F, togglefullscreen"

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
	  "$mod, E, exec, $explorer"
	];

	bindm = [
	  "$mod, mouse:272, movewindow"
	  "$mod, mouse:273, resizewindow"
	];
     };
  };

  # TERMINAL
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      cursor.style = "beam";

      font.normal.family = "FiraCode";
      font.size = 16;

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

  # let home manager install and manage itself
  programs.home-manager.enable = true;
}
