import Quickshell
import Quickshell.Hyprland
import QtQuick

import "root:/cfg"

PopupWindow {
    id: root;
    visible: isVisible();

    required property var anchorItem;
    required property var isVisible;
    required property var toggle;
    property int xoffset: 0;

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
}
