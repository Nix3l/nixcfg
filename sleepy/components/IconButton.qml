import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/style"

Item {
    id: root;

    required property var clicked;

    property int padding: 0;

    property color bgColor: "transparent";
    property color bgHoveredColor: "transparent";
    property color borderColor: Style.colors.bg1;
    property color borderHoveredColor: Style.colors.bg1;
    property int borderSize: 0;

    required property string icon;
    property int iconSize: Style.icons.small;

    implicitWidth: iconSize + padding * 2;
    implicitHeight: iconSize + padding * 2;

    StyledBg {
        color: minput.containsMouse ? root.bgHoveredColor : root.bgColor;
        border.color: minput.containsMouse ? root.borderHoveredColor : root.borderColor;
        border.width: root.borderSize;
    }

    StyledIcon {
        anchors.fill: parent;
        anchors.margins: root.padding;
        source: root.icon;
        implicitSize: root.iconSize;
    }

    MouseArea {
        id: minput;
        anchors.fill: parent;
        hoverEnabled: true;
        acceptedButtons: Qt.LeftButton;
        onClicked: root.clicked();
    }
}
