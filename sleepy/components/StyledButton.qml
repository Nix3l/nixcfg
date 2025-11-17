import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:/cfg"
import "root:/style"
import "root:/services"

Item {
    id: root;

    property bool enabled: true;

    property var clicked;

    property int padding: Style.padding.small;

    property color bgColor: Style.colors.bg0;
    property color bgHoveredColor: Style.colors.bg1;
    property color borderColor: Style.colors.bg1;
    property color borderHoveredColor: Style.colors.bg1;
    property int borderSize: Style.border.thin;

    default property alias items: content.children;

    implicitWidth: content.implicitWidth + padding * 2;
    implicitHeight: content.implicitHeight + padding * 2;

    StyledBg {
        color: minput.containsMouse && root.enabled ? root.bgHoveredColor : root.bgColor;
        border.color: minput.containsMouse && root.enabled ? root.borderHoveredColor : root.borderColor;
        border.width: root.borderSize;
    }

    Item {
        anchors.verticalCenter: parent.verticalCenter;
        anchors.fill: parent;

        RowLayout {
            id: content;
            anchors.centerIn: parent;
            spacing: Style.spacing.small;
        }
    }

    MouseArea {
        id: minput;
        anchors.fill: parent;
        hoverEnabled: true;
        acceptedButtons: Qt.LeftButton;
        onClicked: () => { 
            if(!root.enabled) return;
            if(root.clicked != undefined) root.clicked();
        }
    }
}
