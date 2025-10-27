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
    toggle: (on) => { GlobalState.notifDrawerOpen = on };

    property int padding: Style.padding.normal;

    implicitWidth: Config.notifs.width + padding * 2;
    implicitHeight: Config.notifs.minimumHeight * 8 + header.implicitHeight + padding * 2;

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
                color: Style.colors.fg1;
                font.pointSize: Style.text.normal;
            }

            IconButton {
                id: garbageIcon;
                anchors.right: parent.right;
                source: Icons.notifs.garbage;
                implicitSize: Style.icons.normal;
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
                    borderColor: Style.colors.bg1;
                    hoveredBorderColor: Style.colors.fg0;
                }
            }
        }
    }
}
