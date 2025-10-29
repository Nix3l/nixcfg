import Quickshell
import QtQuick
import QtQuick.Layouts

import "root:/cfg"
import "root:/style"
import "root:/components"

Item {
    id: root;

    property int hpadding: Style.padding.small;

    property color bgColor: Style.colors.bg1;
    property color borderColor: Style.colors.fg0;
    property int borderWidth: 2;

    property int contentSpacing: 4;

    property var hovered;
    property var leftClicked;
    property var rightClicked;

    implicitWidth: content.implicitWidth + hpadding * 2;
    implicitHeight: Config.bar.contentHeight;

    default property alias items: content.children;

    StyledBg {
        color: root.bgColor;
        border.color: root.borderColor
        border.width: root.borderWidth;
        radius: 0;
    }

    Item {
        anchors {
            verticalCenter: parent.verticalCenter;
            fill: parent;
        }

        RowLayout {
            id: content;
            anchors.centerIn: parent;
            spacing: root.contentSpacing;
        }
    }

    MouseArea {
        anchors.fill: parent;
        hoverEnabled: true;
        acceptedButtons: Qt.LeftButton | Qt.RightButton;
        onEntered: if(root.hovered != undefined) root.hovered();
        onPressed: event => {
            if(event.button === Qt.LeftButton && root.leftClicked != undefined)
                root.leftClicked();
            else if(event.button === Qt.RightClicked && root.rightClicked != undefined)
                root.rightClicked();
            else
                event.accepted = false;
        }
    }
}
