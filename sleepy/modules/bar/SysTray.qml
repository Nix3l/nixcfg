import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

import "root:/style"
import "root:/components"

BarItem {
    Item {
        implicitWidth: content.implicitWidth;

        Row {
            id: content;
            spacing: Style.spacing.normal;

            anchors {
                fill: parent;
                centerIn: parent;
            }

            Repeater {
                model: SystemTray.items;

                SysTrayItem {
                    anchors.verticalCenter: parent.verticalCenter;
                }
            }
        }
    }
}
