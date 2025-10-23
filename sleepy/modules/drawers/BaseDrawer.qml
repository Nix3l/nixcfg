import Quickshell
import Quickshell.Hyprland
import QtQuick

import "root:/cfg"
import "root:/style"

PopupWindow {
    id: root;
    visible: isVisible();

    required property var anchorItem;
    required property var isVisible;
    required property var toggle;
    property int xoffset: 0;

    property color bgColor: Style.colors.bg0;
    property color borderColor: Style.colors.acc1;
    property int borderSize: 1;

    color: 'transparent';

    anchor {
        item: root.anchorItem;
        edges: Edges.Bottom;
        gravity: Edges.Bottom;
        rect.height: Config.bar.contentHeight + 6;
        rect.x: root.anchorItem.x + root.xoffset;
    }

    HyprlandFocusGrab {
        active: isVisible();
        windows: [ root ];
        onCleared: {
            root.toggle(false);
        }
    }

    Rectangle {
        anchors.fill: parent;
        color: root.bgColor;
        border {
            color: root.borderColor;
            width: root.borderSize;
        }
    }
}
