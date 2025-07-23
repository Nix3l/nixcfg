{ lib, config, pkgs, ... }:

{
    options.mods.ld = with lib; {
        enable = mkEnableOption "nix-ld";
    };

    config = lib.mkIf config.mods.ld.enable {
        programs.nix-ld = {
            enable = true;
            libraries = with pkgs; [
                # defaults
                zlib
                zstd
                stdenv.cc.cc
                curl
                openssl
                attr
                libssh
                bzip2
                libxml2
                acl
                libsodium
                util-linux
                xz
                systemd

                xorg.libXcomposite
                xorg.libXtst
                xorg.libXrandr
                xorg.libXext
                xorg.libX11
                xorg.libXfixes
                libGL
                libva
                xorg.libxcb
                xorg.libXdamage
                xorg.libxshmfence
                xorg.libXxf86vm
                libelf

                # required
                glib
                gtk2

                xorg.libXinerama
                xorg.libXcursor
                xorg.libXrender
                xorg.libXScrnSaver
                xorg.libXi
                xorg.libSM
                xorg.libICE
                gnome2.GConf
                nspr
                nss
                cups
                libcap
                SDL2
                libusb1
                dbus-glib
                ffmpeg
                libudev0-shim

                gtk3
                icu
                libnotify
                gsettings-desktop-schemas
                libadwaita

                # verified games requirements
                xorg.libXt
                xorg.libXmu
                libogg
                libvorbis
                SDL
                SDL2_image
                glew110
                libidn
                tbb
                glfw
                assimp
                cglm

                # other things from runtime
                flac
                freeglut
                libjpeg
                libpng
                libpng12
                libsamplerate
                libmikmod
                libtheora
                libtiff
                pixman
                speex
                SDL_image
                SDL_ttf
                SDL_mixer
                SDL2_ttf
                SDL2_mixer
                libappindicator-gtk2
                libdbusmenu-gtk2
                libindicator-gtk2
                libcaca
                libcanberra
                libgcrypt
                libvpx
                librsvg
                xorg.libXft
                libvdpau
                pango
                cairo
                atk
                gdk-pixbuf
                fontconfig
                freetype
                dbus
                alsa-lib
                expat
                # needed for electron
                libdrm
                mesa
                libxkbcommon
                # needed to run, via virtualenv + pip, matplotlib & tikzplotlib
                stdenv.cc.cc.lib

                libsForQt5.full
            ];
        };
    };
}
