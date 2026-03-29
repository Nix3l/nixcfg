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
                libGL
                libva

                libxcomposite
                libxtst
                libxrandr
                libxext
                libx11
                libxfixes
                libxcb
                libxdamage
                libxshmfence
                libxxf86vm
                libxinerama
                libxcursor
                libxrender
                libxscrnsaver
                libxi
                libsm
                libice

                # required
                glib
                gtk2
                libelf
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
                libxt
                libxmu
                libogg
                libvorbis
                SDL
                SDL2_image
                glew_1_10
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
                libxft
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
            ];
        };
    };
}
