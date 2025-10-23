pragma Singleton

import Quickshell
import QtQuick

Singleton {
    property Colorscheme gruvbox;

    property Colorscheme colors: gruvbox;

    gruvbox: Colorscheme {
        bg0:   "#1d2021";
        bg1:   "#3c3836";
        fg0:   "#a89984";
        fg1:   "#ebdbb2";
        acc0:  "#689d6a";
        acc1:  "#8ec07c";
        alt0:  "#458588";
        alt1:  "#83a598";
    }
}
