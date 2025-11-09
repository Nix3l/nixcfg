import Quickshell
import Quickshell.Hyprland
import QtQuick

import "root:/cfg"
import "root:/style"
import "root:/components"

PopupWindow {
    id: root;
    visible: isVisible();

    required property var anchorItem;
    required property var isVisible;
    required property var toggle;

    property int padding: Style.padding.small;

    property real xoffset: 0;
    property real yoffset: Config.bar.contentHeight * 1.33;

    property color bgColor: Style.colors.bg0;
    property color borderColor: Style.colors.acc1;
    property int borderSize: Style.border.thin;

    color: "transparent";

    anchor {
        item: root.anchorItem;
        edges: Edges.Bottom;
        gravity: Edges.Bottom;
        rect.x: root.anchorItem.x + root.xoffset + root.anchorItem.width / 2;
        rect.y: root.anchorItem.y + root.yoffset;
    }

    HyprlandFocusGrab {
        active: isVisible();
        windows: [ root ];
        onCleared: {
            root.toggle(false);
        }
    }

    StyledBg {
        radius: Style.rounding.normal;
    }
}
