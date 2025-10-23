import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import QtQuick

import "root:/style"
import "root:/components"

BarItem {
    borderColor: Style.colors.fg0;

    Item {
        id: root;

        property int iconSize: 12;

        implicitWidth: content.implicitWidth;

        Row {
            id: content;
            anchors {
                fill: parent;
                centerIn: parent;
            }

            spacing: 8;
            Repeater {
                model: SystemTray.items;

                SysTrayItem {
                    anchors {
                        verticalCenter: parent.verticalCenter;
                    }

                    required property SystemTrayItem modelData;
                    item: modelData;
                    iconSize: root.iconSize;
                }
            }
        }
    }
}
