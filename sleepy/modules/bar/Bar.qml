import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import "root:/style"
import "root:/cfg"
import "root:/components"
import "root:/services"
import "root:/modules/drawers"
import "root:/modules/drawers/dashboard"
import "root:/modules/drawers/bluetooth"
import "root:/modules/drawers/network"

PanelWindow {
    id: root;

    anchors {
        top: true;
        right: true;
        left: true;
    }

    implicitHeight: Config.bar.height;
    color: "transparent";

    StyledBg {
        border.width: 0;
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
            }

            spacing: Style.spacing.normal;

            Workspaces {}
            MediaStatus { id: media; }
            MediaDrawer { anchorItem: media; }
        }

        // CENTER
        RowLayout {
            anchors.centerIn: parent;
            spacing: Style.spacing.normal;

            Clock { id: clock; }
            DashboardDrawer { anchorItem: clock; }
        }

        // RIGHT
        RowLayout {
            anchors {
                top: parent.top;
                right: parent.right;
                bottom: parent.bottom;
            }

            spacing: Style.spacing.normal;

            BluetoothStatus { id: bluetoothstatus; }
            BluetoothDrawer { anchorItem: bluetoothstatus; }
            NetworkStatus { id: networkstatus; }
            NetworkDrawer { anchorItem: networkstatus; }
            VolumeStatus {}
            PowerStatus {}
            SysTray {}
            NotifStatus { id: notifstatus; }
            NotifDrawer { anchorItem: notifstatus; }
        }
    }
}
