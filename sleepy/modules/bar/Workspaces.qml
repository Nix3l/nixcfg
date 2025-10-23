import Quickshell
import QtQuick

import "root:/cfg"
import "root:/services"
import "root:/style"

BarItem {
    borderColor: Style.colors.fg0;

    Item {
        id: root;

        property real workspaceSize: 8;
        property real workspaceSpacing: 8;
        property real focusScale: 3.0;

        implicitWidth: content.implicitWidth;

        Row {
            id: content;
            anchors {
                fill: parent;
                centerIn: parent;
            }

            spacing: root.workspaceSpacing;

            Repeater {
                model: Config.bar.numWorkspacesShown;

                Item {
                    id: ws;

                    function focused(): bool {
                        return Hyprland.activeWorkspace?.id == index + 1;
                    }

                    anchors {
                        verticalCenter: content.verticalCenter;
                    }

                    implicitWidth: bg.implicitWidth;
                    implicitHeight: bg.implicitHeight;

                    Rectangle {
                        id: bg;

                        implicitWidth: root.workspaceSize * (ws.focused() ? root.focusScale : 1);
                        implicitHeight: root.workspaceSize;

                        radius: root.workspaceSize / 2.0;

                        color: {
                            if(ws.focused()) return Style.colors.fg1;
                            else return Style.colors.fg0;
                        }
                    }
                }
            }
        }
    }
}
