pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:/cfg"
import "root:/style"
import "root:/services/notifs"
import "root:/modules/osd/notif"
import "root:/components"

BaseDrawer {
    id: root;

    isVisible: () => GlobalState.notifDrawerOpen;
    toggle: (on) => { GlobalState.notifDrawerOpen = on }

    property int padding: Style.padding.normal;

    implicitWidth: Config.notifs.width + padding * 2;
    implicitHeight: Config.notifs.minimumHeight * 8 + header.implicitHeight + padding * 2;

    ColumnLayout {
        id: content;
        anchors.fill: parent;
        anchors.margins: root.padding;
        spacing: root.padding;

        RowLayout {
            id: header;
            Layout.fillWidth: true;
            Layout.alignment: Qt.AlignTop;

            implicitHeight: Math.max(titleText.implicitHeight, garbageIcon.implicitSize);

            StyledText {
                id: titleText;
                Layout.alignment: Qt.AlignLeft;
                text: "Notifications";
                font.pointSize: Style.text.normal;
            }

            Rectangle {
                Layout.fillWidth: true;
                color: Style.colors.fg1;
                implicitHeight: Style.border.thin;
            }

            IconButton {
                id: garbageIcon;
                Layout.alignment: Qt.AlignRight;
                icon: Icons.notifs.garbage;
                clicked: () => { Notifs.clear(); }
            }
        }

        StyledList {
            Layout.fillWidth: true;
            Layout.fillHeight: true;
            items.model: Notifs.notifs;
            items.delegate: NotifItem {
                borderColor: Style.colors.bg1;
                hoveredBorderColor: Style.colors.fg0;
            }
        }
    }
}
