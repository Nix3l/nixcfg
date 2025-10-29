import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import QtQuick

import "root:/style"

MouseArea {
    id: root;

    acceptedButtons: Qt.LeftButton | Qt.RightButton;

    required property SystemTrayItem modelData;
    property int iconSize: Style.icons.smallest;

    implicitWidth: icon.implicitSize;
    implicitHeight: icon.implicitSize;

    QsMenuAnchor {
        id: menu;
        menu: root.modelData.menu;

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
        if(event.button === Qt.LeftButton) modelData.activate();
        if(event.button === Qt.RightButton) menu.open();
    }

    IconImage {
        id: icon;
        anchors.verticalCenter: parent.verticalCenter;
        source: root.modelData.icon;
        mipmap: true;
        implicitSize: root.iconSize;
    }
}
