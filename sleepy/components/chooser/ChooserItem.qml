import Quickshell
import QtQuick

import "root:/cfg"
import "root:/style"

Item {
    id: root;

    implicitWidth: Config.chooser.contentWidth;
    implicitHeight: Config.chooser.itemHeight;

    required property var modelData;
    required property var chooser;

    property bool containsMouse: mouseArea.containsMouse;

    property var mouseEntered;
    property var mouseExited;
    property var leftClicked;
    property var rightClicked;

    property bool selected: containsMouse || ListView.isCurrentItem;

    Rectangle {
        visible: root.selected;
        z: 0;
        anchors.fill: parent;
        anchors.verticalCenter: parent.verticalCenter;
        color: Style.colors.fg;
    }

    MouseArea {
        id: mouseArea;
        anchors.fill: parent;
        acceptedButtons: Qt.LeftButton | Qt.RightButton;
        hoverEnabled: true;

        onPressed: event => {
            if(event.button === Qt.LeftButton && root.leftClicked != undefined) {
                root.leftClicked();
            } else if(event.button === Qt.RightButton && root.rightClicked != undefined) {
                root.rightClicked();
            }
        };

        onEntered: if(mouseEntered != undefined) root.mouseEntered();
        onExited: if(mouseExited != undefined) root.mouseExited();
    }
}
