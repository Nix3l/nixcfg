import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:/cfg"
import "root:/style"
import "root:/components"
import "root:/services"
import "root:/modules/drawers"

// TODO(nix3l): test the pairing/connecting more

BaseDrawer {
    id: root;

    isVisible: () => GlobalState.bluetoothDrawerOpen;
    toggle: (on) => { GlobalState.bluetoothDrawerOpen = on }

    property int padding: Style.padding.small;

    implicitWidth: Math.max(content.implicitWidth + padding * 2, 320);
    implicitHeight: Math.max(content.implicitHeight + padding * 2, 480);

    ColumnLayout {
        id: content;
        anchors.fill: parent;
        anchors.margins: root.padding;
        spacing: Style.spacing.small;

        RowLayout {
            Layout.fillWidth: true;
            spacing: Style.spacing.small;

            StyledText {
                Layout.alignment: Qt.AlignLeft;
                text: "Bluetooth";
                font.pointSize: Style.text.normal;
            }

            Rectangle {
                Layout.fillWidth: true;
                color: Style.colors.fg1;
                implicitHeight: Style.border.thin;
            }
        }

        RowLayout {
            Layout.fillWidth: true;
            spacing: Style.spacing.small;

            StyledButton {
                Layout.fillWidth: true;

                enabled: !Bluetooth.occupied;
                clicked: () => Bluetooth.adapter.enabled = !Bluetooth.adapter.enabled;

                StyledText {
                    text: {
                        if(Bluetooth.enabling) return "Enabling...";
                        if(Bluetooth.disabling) return "Disabling...";
                        if(Bluetooth.adapter.enabled) return "Disable";
                        if(!Bluetooth.adapter.enabled) return "Enable";
                    }

                    color: Bluetooth.occupied ? Style.colors.fg0 : Style.colors.fg1;
                }
            }

            StyledButton {
                Layout.alignment: Qt.AlignRight;

                clicked: () => {
                    if(!Bluetooth.enabled) return;
                    Bluetooth.adapter.discovering = !Bluetooth.adapter.discovering;
                }

                StyledText {
                    text: Bluetooth.discovering ? "Discovering..." : "Discover";
                }

                LoadingCircle {
                    visible: Bluetooth.discovering;
                }
            }
        }

        Item {
            visible: !Bluetooth.enabled;
            Layout.fillWidth: true;
            Layout.fillHeight: true;

            StyledText {
                anchors.centerIn: parent;
                text: "空";
                color: Style.colors.fg0;
                font.pointSize: Style.text.largest;
            }
        }

        StyledList {
            visible: Bluetooth.enabled;
            Layout.fillWidth: true;
            Layout.fillHeight: true;
            items.model: Bluetooth.devices;
            items.delegate: BluetoothItem {
                anchors.left: parent.left;
                anchors.right: parent.right;
            }
        }

        StyledText {
            visible: Bluetooth.enabled;
            Layout.alignment: Qt.AlignHCenter;
            text: "以上";
        }
    }
}
