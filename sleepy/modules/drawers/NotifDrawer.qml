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
import "root:/util"

BaseDrawer {
    id: root;

    isVisible: () => GlobalState.notifDrawerOpen;
    toggle: (on) => { GlobalState.notifDrawerOpen = on };

    property int padding: 8;

    implicitWidth: Config.notifs.width + padding * 2;
    implicitHeight: Config.notifs.minimumHeight * 8 + header.implicitHeight + padding * 2;

    Rectangle {
        anchors.fill: parent;
        color: Style.colors.bg0;
        border {
            width: 1;
            color: Style.colors.accent;
        }
    }

    ColumnLayout {
        id: content;
        anchors.fill: parent;
        anchors.margins: root.padding;
        spacing: root.padding;

        Item {
            id: header;
            Layout.fillWidth: true;
            Layout.alignment: Qt.AlignTop;

            implicitHeight: Math.max(titleText.implicitHeight, garbageIcon.implicitSize);

            Text {
                id: titleText;
                anchors.left: parent.left;
                text: "Notifications";
                color: Style.colors.fg;
                font.pixelSize: 16;
            }

            IconButton {
                id: garbageIcon;
                anchors.right: parent.right;
                source: Icons.notifs.garbage;
                implicitSize: 16;
                clicked: () => { Notifs.clear(); };
            }
        }

        ClippingRectangle {
            Layout.fillWidth: true;
            Layout.fillHeight: true;
            color: 'transparent';

            implicitHeight: notiflist.implicitHeight;

            ListView {
                id: notiflist;
                anchors.fill: parent;

                orientation: Qt.Vertical;
                spacing: root.padding;

                model: Notifs.notifs;
                delegate: NotifItem {
                    borderCol: Style.colors.bg1;
                    hoveredBorderCol: Style.colors.fgMuted;
                }
            }
        }
    }
}
