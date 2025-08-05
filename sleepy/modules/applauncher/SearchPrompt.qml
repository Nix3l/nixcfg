import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:/style"
import "root:/cfg"

Item {
    id: root;

    property string text: inputfield.text;
    default property alias field: inputfield;

    Layout.fillWidth: true;
    Layout.alignment: Qt.AlignTop;

    implicitHeight: Config.applauncher.promptHeight;

    TextField {
        id: inputfield;

        anchors.fill: parent;
        color: Style.colors.fg;

        placeholderTextColor: Style.colors.fgMuted;
        placeholderText: "Search";

        background: Rectangle {
            anchors.fill: parent;
            color: Style.colors.bg1;
        }

        focus: true;
    }
}
