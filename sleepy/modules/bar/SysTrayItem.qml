import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick

import "root:/style"

MouseArea {
    id: root;

    acceptedButtons: Qt.LeftButton | Qt.RightButton;

    required property SystemTrayItem item;
    property int iconSize: 12;

    implicitWidth: icon.implicitSize;
    implicitHeight: icon.implicitSize;

    QsMenuAnchor {
        id: menu;

        menu: root.item.menu;

        anchor {
            item: root;
            edges: Edges.Bottom;

            rect {
                x: root.x;
                y: root.y;
                height: root.height * 2;
            }
        }
    }

    onClicked: event => {
        if(event.button === Qt.LeftButton) item.activate();
        if(event.button === Qt.RightButton) menu.open();
    }

    IconImage {
        id: icon;
        anchors {
            verticalCenter: parent.verticalCenter;
        }

        source: root.item.icon;
        mipmap: true;
        implicitSize: root.iconSize;
    }
}
