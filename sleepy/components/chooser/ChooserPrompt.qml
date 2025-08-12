import Quickshell
import QtQuick
import QtQuick.Controls

import "root:/cfg"
import "root:/style"

Item {
    id: root;

    property alias field: inputfield;

    implicitWidth: Config.chooser.contentWidth;
    implicitHeight: Config.chooser.itemHeight;

    property color bg: Style.colors.bg0;

    Rectangle {
        anchors.fill: parent;
        color: root.bg;
    }

    Item {
        anchors.fill: parent;
        anchors.margins: Config.chooser.promptPadding;

        TextField {
            id: inputfield;
            anchors.verticalCenter: parent.verticalCenter;
            implicitWidth: Config.chooser.contentWidth - Config.chooser.promptPadding * 2;

            color: Style.colors.fg;
            font.pixelSize: Config.chooser.promptFontSize;

            placeholderText: "Search...";
            placeholderTextColor: Style.colors.bg1;

            background: null;
            focus: true;
        }
    }
}
