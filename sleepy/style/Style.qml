pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

import "root:/cfg"

Singleton {
    property var colors: Config.style.colors;
    property var border: Config.style.border;
    property var rounding: Config.style.rounding;
    property var padding: Config.style.padding;
    property var fonts: Config.style.fonts;
    property var text: Config.style.text;
    property var icons: Config.style.icons;
}
