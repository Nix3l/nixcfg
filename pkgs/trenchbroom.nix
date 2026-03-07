{ appimageTools, fetchzip, makeDesktopItem }:

appimageTools.wrapType2 rec {
    name = "TrenchBroom";
    pname = name;
    version = "v2025.4";

    src = "${fetchzip {
        url = "https://github.com/TrenchBroom/TrenchBroom/releases/download/${version}/TrenchBroom-Linux-x86_64-${version}-Release.zip";
        hash = "sha256-qsuZ2eDvZphAza/G0qfc7ihNPnqwhwMz8fj4dlYF+FY=";
    }}/TrenchBroom.AppImage";

    appImageContent = appimageTools.extract { inherit pname version src; };

    desktopItem =
        (makeDesktopItem rec {
            inherit name;
            exec = "TrenchBroom %U";
            desktopName = name;
            comment = "CSG map editor";
        });

    extraInstallCommands = ''
        mkdir -p $out/share/applications/
        cp ${desktopItem}/share/applications/*.desktop $out/share/applications/
    '';
}
