pragma Singleton

import Quickshell
import QtQuick

Singleton {
    property Colorscheme gruvbox;

    property Colorscheme colors: gruvbox;

    gruvbox: Colorscheme {
        bg0:     "#1d2021";
        bg1:     "#3c3836";
        fg:      "#ebdbb2";
        fgMuted: "#a89984";
        accent:  "#fb4934";
    }
}
