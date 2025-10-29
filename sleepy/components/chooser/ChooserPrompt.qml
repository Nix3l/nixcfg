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

    property color bg: Style.colors.acc1;

    StyledBg {
        color: root.bg;
        border.width: 2;
        border.color: Style.colors.acc1;
    }

    Item {
        anchors {
            fill: parent;
            margins: Config.chooser.promptPadding;
        }

        TextField {
            id: inputfield;
            anchors.verticalCenter: parent.verticalCenter;
            implicitWidth: Config.chooser.contentWidth - Config.chooser.promptPadding * 2;

            color: Style.colors.bg0;
            font.pixelSize: Config.chooser.promptFontSize;
            font.family: Style.fonts.normal;

            placeholderText: "Search...";
            placeholderTextColor: Style.colors.bg0;

            background: null;
            focus: true;
        }
    }
}
