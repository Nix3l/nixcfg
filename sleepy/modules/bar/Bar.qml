import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import "root:/style"
import "root:/cfg"
import "root:/services"
import "root:/modules/drawers"
import "root:/modules/drawers/dashboard"

PanelWindow {
    id: root;

    anchors {
        top: true;
        right: true;
        left: true;
    }

    implicitHeight: Config.bar.height;
    color: "transparent";

    Rectangle {
        anchors.fill: parent;
        color: Style.colors.bg0;
    }

    Item {
        anchors {
            fill: parent;

            topMargin: Config.bar.vpadding;
            bottomMargin: Config.bar.vpadding;
            rightMargin: Config.bar.hpadding;
            leftMargin: Config.bar.hpadding;
        }

        implicitHeight: Config.bar.contentHeight;

        // LEFT
        RowLayout {
            anchors {
                top: parent.top;
                bottom: parent.bottom;
                left: parent.left;

                leftMargin: 4;
            }

            spacing: 8;

            Workspaces {}
            MediaStatus { id: media; }
            MediaDrawer { anchorItem: media; }
        }

        // CENTER
        RowLayout {
            anchors.centerIn: parent;
            spacing: 8;

            Clock { id: clock; }
            DashboardDrawer { anchorItem: clock; }
        }

        // RIGHT
        RowLayout {
            anchors {
                top: parent.top;
                right: parent.right;
                bottom: parent.bottom;
                rightMargin: 4;
            }

            spacing: 8;

            Loader {
                active: Config.modules.bluetoothStatus;
                BluetoothStatus {}
            }

            NetworkStatus {}
            VolumeStatus {}

            Loader {
                active: Config.modules.powerStatus;
                PowerStatus {}
            }

            SysTray {}
            NotifStatus { id: notifstatus; }
            NotifDrawer { anchorItem: notifstatus; }
        }
    }
}
