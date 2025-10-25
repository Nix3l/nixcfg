import Quickshell
import Quickshell.Io
import QtQuick

import "root:/cfg"
import "root:/style"

Rectangle {
    id: root;
    z: -1;
    anchors.fill: parent;

    property int borderSize: Style.border.normal;
    property color borderColor: Style.colors.acc1;

    color: Style.colors.bg0;
    border {
        width: root.borderSize;
        color: root.borderColor;
    }
}
