import Quickshell
import Quickshell.Io
import Quickshell.Widgets
import QtQuick

import "root:/cfg"
import "root:/style"

Rectangle {
    id: root;
    z: -1;
    anchors.fill: parent;

    color: Style.colors.bg0;
    border {
        width: Style.border.normal;
        color: Style.colors.acc1;
    }

    radius: Style.rounding.normal;
}
