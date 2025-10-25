pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import "root:/cfg"

Singleton {
    property Colorscheme colors: Colorscheme {
        // gruvbox
        bg0:  "#1d2021";
        bg1:  "#3c3836";
        fg0:  "#a89984";
        fg1:  "#ebdbb2";
        acc0: "#689d6a";
        acc1: "#8ec07c";
        alt0: "#458588";
        alt1: "#83a598";
    }

    property var border: Config.style.border;
    property var fonts: Config.style.fonts;
    property var text: Config.style.text;
}
