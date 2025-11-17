import Quickshell
import Quickshell.Widgets
import Quickshell.Bluetooth
import QtQuick
import QtQuick.Layouts

import "root:/style"
import "root:/cfg"
import "root:/components"

Item {
    id: root;

    required property var modelData;

    property bool connecting: modelData.state == BluetoothDeviceState.Connecting;
    property bool disconnecting: modelData.state == BluetoothDeviceState.Disconnecting;
    property bool pairing: modelData.pairing;
    property bool occupied: connecting || disconnecting || pairing;

    property string icon: modelData.icon != "" ? Quickshell.iconPath(modelData.icon) : Icons.other.unknown;

    property int padding: Style.padding.normal;

    property color bgColor: Style.colors.bg0;
    property color borderColor: Style.colors.bg1;
    property int borderSize: Style.border.thin;

    implicitHeight: content.implicitHeight + padding * 2;

    property bool expand: false;

    StyledBg {
        color: root.bgColor;
        border.color: root.borderColor;
        border.width: root.borderSize;
    }

    ColumnLayout {
        id: content;
        anchors.fill: parent;
        anchors.margins: root.padding;
        spacing: Style.spacing.large;

        RowLayout {
            Layout.fillWidth: true;
            spacing: Style.spacing.small;

            IconButton {
                Layout.alignment: Qt.AlignLeft;
                icon: Icons.controls.menu;
                iconSize: Style.icons.large;
                clicked: () => { root.expand = !root.expand; }
            }

            StyledIcon {
                Layout.alignment: Qt.AlignLeft;
                source: root.icon;
            }

            StyledText {
                Layout.alignment: Qt.AlignLeft;
                text: modelData.name;
                font.pointSize: Style.text.normal;
            }

            StyledText {
                visible: modelData.paired;
                Layout.alignment: Qt.AlignLeft;
                text: {
                    "(" +
                    (modelData.paired ? "Paired" : "") +
                    (modelData.connected ? ", connected" : "") +
                    ")"
                }

                color: Style.colors.fg0;
                font.pointSize: Style.text.smallest;
            }

            Item { Layout.fillWidth: true; }

            LoadingCircle {
                visible: root.occupied;
                Layout.alignment: Qt.AlignRight;
            }
        }

        RowLayout {
            visible: root.expand;
            Layout.fillWidth: true;
            spacing: Style.spacing.small;

            StyledButton {
                id: connectButton;
                visible: modelData.paired;
                Layout.fillWidth: true;
                Layout.alignment: Qt.AlignLeft;

                enabled: !root.occupied;
                clicked: () => modelData.connected = !modelData.connected;

                StyledText {
                    text: modelData.connected ? "Disconnect" : "Connect";
                    color: connectButton.enabled ? Style.colors.fg1 : Style.colors.fg0;
                }
            }

            StyledButton {
                id: forgetButton;
                visible: modelData.paired;
                Layout.fillWidth: true;
                Layout.alignment: Qt.AlignLeft;

                enabled: !root.occupied;
                clicked: () => modelData.forget();

                StyledText {
                    text: "Forget";
                    color: forgetButton.enabled ? Style.colors.fg1 : Style.colors.fg0;
                }
            }

            StyledButton {
                visible: !modelData.paired;
                Layout.fillWidth: true;
                Layout.alignment: Qt.AlignLeft;

                clicked: () => {
                    if(!root.pairing) modelData.pair();
                    else modelData.cancelPair();
                }

                StyledText {
                    text: root.pairing ? "Pairing..." : "Pair";
                    color: Style.colors.fg1;
                }
            }
        }

        ColumnLayout {
            visible: root.expand;
            Layout.fillWidth: true;
            Layout.fillHeight: true;
            spacing: Style.spacing.small;

            TextLabel {
                label: "Address:";
                text: modelData.address;
            }

            TextLabel {
                label: "Device Name:";
                text: modelData.deviceName;
            }

            TextLabel {
                visible: modelData.batteryAvailable;
                label: "Battery:";
                text: Math.floor(modelData.battery * 100) + "%";
            }

            TextLabel {
                visible: modelData.paired;
                label: "Trusted"

                EnableButton {
                    enabled: modelData.trusted;
                    clicked: () => modelData.trusted = enabled;
                }
            }

            TextLabel {
                visible: modelData.paired;
                label: "Blocked"

                EnableButton {
                    enabled: modelData.blocked;
                    clicked: () => modelData.blocked = enabled;
                }
            }
        }
    }
}
