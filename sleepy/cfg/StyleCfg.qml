import Quickshell.Io

JsonObject {
    property Border border: Border {};
    property Padding padding: Padding {};
    property Fonts fonts: Fonts {};
    property TextSize text: TextSize {};

    component Border: JsonObject {
        property int thin: 1;
        property int normal: 2;
        property int thick: 4;
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
        property int small: 8;
        property int normal: 11;
    }
}
