{
    stdenvNoCC,
    fetchFromGitHub,
    kdePackages,
}:

stdenvNoCC.mkDerivation {
    name = "qylock-sddm";

    src = fetchFromGitHub {
        owner = "Darkkal44";
        repo = "qylock";
        rev = "main";
        sha256 = "sha256-b086NbnHk0gsqx5HiRpbBV85Y29A14+1HhqwevqbgwU=";
    };

    dontWrapQtApps = true;

    installPhase = ''
        mkdir -p $out/share/sddm/themes/hollowknight
        cp -r $src/themes/pixel-hollowknight/* $out/share/sddm/themes/hollowknight/
    '';

    propagatedBuildInputs = with kdePackages; [
        qtdeclarative
        qtsvg
        qtmultimedia
        qt5compat
    ];
}
