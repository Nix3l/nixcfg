import Quickshell.Io
import QtQuick

JsonObject {
    property Colorscheme colors: Colorscheme {};
    property Border border: Border {};
    property Rounding rounding: Rounding {};
    property Padding padding: Padding {};
    property Spacing spacing: Spacing {};
    property Fonts fonts: Fonts {};
    property TextSize text: TextSize {};
    property IconSize icons: IconSize {};
    property Animations anim: Animations {};

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

    component Spacing: JsonObject {
        property int smallest: 2;
        property int small: 4;
        property int normal: 8;
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

    // shamelessly stolen from https://github.com/caelestia-dots/shell/blob/main/config/AppearanceConfig.qml
    // woo
    component AnimationCurve: JsonObject {
        property list<real> emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1];
        property list<real> emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1];
        property list<real> emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1];
        property list<real> standard: [0.2, 0, 0, 1, 1, 1];
        property list<real> standardAccel: [0.3, 0, 1, 1, 1, 1];
        property list<real> standardDecel: [0, 0, 0, 1, 1, 1];
        property list<real> expressiveFastSpatial: [0.42, 1.67, 0.21, 0.9, 1, 1];
        property list<real> expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1, 1, 1];
        property list<real> expressiveEffects: [0.34, 0.8, 0.34, 1, 1, 1];
    }

    component AnimationDuration: JsonObject {
        property int small: 200;
        property int normal: 400;
        property int large: 600;
        property int largest: 1000;
    }

    component Animations: JsonObject {
        property AnimationDuration durations: AnimationDuration {};
        property AnimationCurve curves: AnimationCurve {};
    }
}
