import Quickshell
import QtQuick
import QtQuick.Layouts

import "root:/cfg"
import "root:/style"
import "root:/components"

Item {
    id: root;

    property int hpadding: 10;

    property color bgColor: Style.colors.bg1;
    property color borderColor: Style.colors.acc0;

    property int contentSpacing: 4;

    property var hovered;
    property var leftClicked;
    property var rightClicked;

    implicitWidth: content.implicitWidth + hpadding * 2;
    implicitHeight: Config.bar.contentHeight;

    default property alias items: content.children;

    Rectangle {
        anchors.fill: parent;
        color: root.bgColor;
        border {
            width: 2;
            color: root.borderColor;
        }
    }

    Item {
        anchors {
            verticalCenter: parent.verticalCenter;
            fill: parent;
        }

        RowLayout {
            id: content;
            anchors {
                centerIn: parent;
            }

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
