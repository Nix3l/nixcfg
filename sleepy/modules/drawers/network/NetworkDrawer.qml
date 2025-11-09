import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:/cfg"
import "root:/style"
import "root:/components"
import "root:/services"
import "root:/modules/drawers"

BaseDrawer {
    id: root;

    isVisible: () => GlobalState.drawers.network;
    toggle: (on) => { GlobalState.drawers.network = on }

    implicitWidth: Math.max(content.implicitWidth + padding * 2, 320);
    implicitHeight: Math.max(content.implicitHeight + padding * 2, 480);

    ColumnLayout {
        id: content;
        anchors.fill: parent;
        anchors.margins: root.padding;
        spacing: Style.spacing.small;

        RowLayout {
            Layout.alignment: Qt.AlignTop;
            Layout.fillWidth: true;
            spacing: Style.spacing.small;

            StyledText {
                Layout.alignment: Qt.AlignLeft;
                text: "Network";
                font.pointSize: Style.text.normal;
            }

            Rectangle {
                Layout.fillWidth: true;
                color: Style.colors.fg1;
                implicitHeight: Style.border.thin;
            }
        }
    }
}
