import Quickshell
import QtQuick
import QtQuick.Controls

import "root:/cfg"
import "root:/style"
import "root:/components"

Item {
    id: root;

    property alias field: inputfield;

    implicitWidth: Config.chooser.contentWidth;
    implicitHeight: Config.chooser.itemHeight;

    property color bg: Style.colors.bg1;
    property color textColor: Style.colors.fg1;
    property color placeholderColor: Style.colors.fg0;

    Item {
        anchors {
            fill: parent;
            margins: Config.chooser.promptPadding;
        }

        TextField {
            id: inputfield;
            anchors.verticalCenter: parent.verticalCenter;
            implicitWidth: Config.chooser.contentWidth - Config.chooser.promptPadding * 2;

            color: root.textColor;
            font.pointSize: Config.chooser.promptFontSize;
            font.family: Style.fonts.normal;

            placeholderText: "Search...";
            placeholderTextColor: root.placeholderColor;

            background: null;
            focus: true;
        }
    }
}
