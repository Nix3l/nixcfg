import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/cfg"
import "root:/style"
import "root:/services"
import "root:/components"

Item {
    id: root;

    property int padding: 8;

    property string icon: "";
    property int iconSize: 32;

    property color bg: Style.colors.bg0;
    property color hoveredBg: Style.colors.bg1;
    property int border: 1;
    property color borderCol: Style.colors.Style.colors.bg1;
    property color hoveredBorderCol: Style.colors.acc1;

    property var leftClicked;

    implicitWidth: iconSize + padding * 2;
    implicitHeight: iconSize + padding * 2;

    IconImage {
        z: 1;
        anchors.centerIn: parent;
        source: root.icon;
        implicitSize: iconSize;
        mipmap: true;
    }

    Rectangle {
        anchors.fill: parent;
        color: mouseArea.containsMouse ? root.hoveredBg : root.bg;
        border {
            width: root.border;
            color: mouseArea.containsMouse ? root.hoveredBorderCol : root.borderCol;
        }
    }

    MouseArea {
        id: mouseArea;
        anchors.fill: parent;
        hoverEnabled: true;
        onPressed: if(root.leftClicked != undefined) root.leftClicked();
    }
}
