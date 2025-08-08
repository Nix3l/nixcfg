import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import "root:/style"
import "root:/cfg"
import "root:/services"
import "root:/modules/drawers"

/*
 * LEFT:
 *  => workspaces TODO(nix3l): animations
 *  => media TODO(nix3l): drawer, shortening
 *
 * CENTER:
 *  => time TODO(nix3l): drawer
 *
 * RIGHT:
 *  => bluetooth        [ ]
 *  => wifi             [*] TODO: fix the icon looking kinda weird
 *  => battery          [ ]
 *  => volume           [*]
 *  => systray          [*]
 *  => notif drawer     [ ]
 */

PanelWindow {
    anchors {
        top: true;
        right: true;
        left: true;
    }

    implicitHeight: Config.bar.height;
    color: "transparent";

    // BACKGROUND
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

            BarItem {
                leftGlyph: "|[";
                rightGlyph: "]|";

                IconImage {
                    source: Icons.os.nixos;
                    mipmap: true;
                    implicitSize: 16;
                }
            }

            Workspaces {}
            MediaStatus { id: media; }
            MediaDrawer { anchorItem: media; }
        }

        // CENTER
        RowLayout {
            anchors.centerIn: parent;
            spacing: 8;

            Clock {}
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

            BluetoothStatus {}
            NetworkStatus {}
            Volume {}
            SysTray {}
            NotificationStatus {}
        }
    }
}
