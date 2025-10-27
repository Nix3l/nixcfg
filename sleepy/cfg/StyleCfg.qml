import Quickshell.Io
import QtQuick

JsonObject {
    property Colorscheme colors: Colorscheme {};
    property Border border: Border {};
    property Rounding rounding: Rounding {};
    property Padding padding: Padding {};
    property Fonts fonts: Fonts {};
    property TextSize text: TextSize {};
    property IconSize icons: IconSize {};

    component Border: JsonObject {
        property int thin: 1;
        property int normal: 2;
        property int thick: 4;
    }

    component Rounding: JsonObject {
        property int normal: 8;
        property int heavy: 12;
        property int full: 9999;
    }

    component Padding: JsonObject {
        property int smallest: 4;
        property int small: 8;
        property int normal: 12;
        property int large: 16;
        property int largest: 24;
    }

    component Fonts: JsonObject {
        property string normal: "Rubik";
        property string mono: "Tamzen";
    }

    component TextSize: JsonObject {
        property int smallest: 8;
        property int small: 9;
        property int normal: 11;
        property int large: 14;
        property int largest: 22;
        property int colossal: 38;
    }

    component IconSize: JsonObject {
        property int smallest: 12;
        property int small: 14;
        property int normal: 16;
        property int large: 22;
        property int largest: 32;
    }

    component Colorscheme: JsonObject {
        property color bg0:  "#1d2021";
        property color bg1:  "#3c3836";
        property color fg0:  "#a89984";
        property color fg1:  "#ebdbb2";
        property color acc0: "#689d6a";
        property color acc1: "#8ec07c";
        property color alt0: "#458588";
        property color alt1: "#83a598";
    }
}
