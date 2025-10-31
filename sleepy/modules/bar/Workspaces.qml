import Quickshell
import QtQuick

import "root:/cfg"
import "root:/services"
import "root:/style"

BarItem {
    id: root;

    property real workspaceSize: 8;
    property real workspaceSpacing: Style.spacing.normal;
    property real focusScale: 3.0;

    borderColor: Style.colors.fg0;

    Row {
        id: content;
        spacing: root.workspaceSpacing;

        Repeater {
            model: Config.bar.numWorkspacesShown;

            Item {
                id: ws;

                anchors.verticalCenter: content.verticalCenter;

                implicitWidth: bg.implicitWidth;
                implicitHeight: bg.implicitHeight;

                function focused(): bool {
                    return Hyprland.activeWorkspace?.id == index + 1;
                }

                Rectangle {
                    id: bg;

                    implicitWidth: root.workspaceSize * (ws.focused() ? root.focusScale : 1.0);
                    implicitHeight: root.workspaceSize;

                    radius: Style.rounding.full;

                    color: ws.focused() ? Style.colors.fg1 : Style.colors.fg0;
                }
            }
        }
    }
}
