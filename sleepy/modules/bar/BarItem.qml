import Quickshell
import QtQuick
import QtQuick.Layouts

import "root:/cfg"
import "root:/style"

Item {
    id: root;

    property int hpadding: 4;
    property color bgColor: Style.colors.bg1;
    property int contentSpacing: 4;
    property real decorationRatio: 0.75;
    property string leftGlyph: "[";
    property string rightGlyph: "]";

    property var toggleDrawer;

    implicitWidth: content.implicitWidth + hpadding * 4 + leftDecoration.implicitWidth + rightDecoration.implicitWidth;
    implicitHeight: Config.bar.contentHeight;

    default property alias items: content.children;

    readonly property int decorationSize: Config.bar.contentHeight * root.decorationRatio;

    Rectangle {
        anchors.fill: parent;
        color: root.bgColor;
    }

    Text {
        id: leftDecoration;

        anchors {
            top: parent.top;
            bottom: parent.bottom;
            left: parent.left;
            topMargin: (Config.bar.contentHeight - root.decorationSize) / 2.0;
            leftMargin: root.hpadding;
        }

        text: root.leftGlyph;
        color: Style.colors.accent;
        font {
            pixelSize: root.decorationSize;
            bold: true;
        }
    }

    Text {
        id: rightDecoration;

        anchors {
            top: parent.top;
            bottom: parent.bottom;
            right: parent.right;
            topMargin: (Config.bar.contentHeight - root.decorationSize) / 2.0;
            rightMargin: root.hpadding;
        }

        text: root.rightGlyph;
        color: Style.colors.accent;
        font {
            pixelSize: root.decorationSize;
            bold: true;
        }
    }

    RowLayout {
        id: content;
        anchors {
            verticalCenter: parent.verticalCenter;
            left: leftDecoration.right;
            right: rightDecoration.left;
            leftMargin: root.hpadding;
            rightMargin: root.hpadding;
        }

        spacing: root.contentSpacing;
    }

    MouseArea {
        anchors.fill: parent;
        hoverEnabled: true;
        onEntered: if(root.toggleDrawer != undefined) root.toggleDrawer(true);
    }
}
