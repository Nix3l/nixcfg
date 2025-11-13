import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import "root:/cfg"
import "root:/style"
import "root:/components"
import "root:/services"
import "root:/services/network"
import "root:/modules/drawers"

Item {
    id: root;

    required property WifiNetwork modelData;

    property int padding: Style.padding.normal;

    property color bgColor: Style.colors.bg0;
    property color borderColor: Style.colors.bg1;
    property int borderSize: Style.border.thin;

    implicitHeight: content.implicitHeight + padding * 2;

    StyledBg {
        color: root.bgColor;
        border.color: root.borderColor;
        border.width: root.borderSize;
    }

    property bool expand: false;

    ColumnLayout {
        id: content;
        anchors.fill: parent;
        anchors.margins: root.padding;
        spacing: Style.spacing.large;

        RowLayout {
            Layout.fillWidth: true;
            spacing: Style.spacing.small;

            Item {
                implicitWidth: headerBar.implicitWidth;
                implicitHeight: headerBar.implicitHeight;

                RowLayout {
                    id: headerBar;
                    spacing: Style.spacing.small;

                    StyledIcon {
                        Layout.alignment: Qt.AlignLeft;
                        source: Icons.wifiStrengthIcon(modelData.strength);
                        implicitSize: Style.icons.normal;
                    }

                    StyledText {
                        text: root.modelData.ssid;
                        font.pointSize: Style.text.normal;
                    } 

                    StyledText {
                        visible: root.modelData.connected;
                        text: "(Connected)";
                        font.pointSize: Style.text.smallest;
                        color: Style.colors.fg0;
                    } 
                }

                MouseArea {
                    anchors.fill: headerBar;
                    acceptedButtons: Qt.LeftButton;
                    onPressed: root.expand = !root.expand;
                }
            }
        }

        RowLayout {
            visible: root.expand;
            Layout.fillWidth: true;
            spacing: Style.spacing.small;

            StyledButton {
                Layout.fillWidth: true;
                visible: !modelData.connected;
                clicked: () => console.log("woah");
                StyledText { text: "Connect"; }
            }

            StyledButton {
                Layout.fillWidth: true;
                visible: modelData.connected;
                clicked: () => console.log("woah");
                StyledText { text: "Disconnect"; }
            }

            StyledButton {
                Layout.fillWidth: true;
                visible: modelData.bonded;
                clicked: () => console.log("woah");
                StyledText { text: "Forget"; }
            }
        }

        TextPrompt {
            visible: root.expand;
            Layout.fillWidth: true;
            implicitHeight: 32;
        }

        ColumnLayout {
            visible: root.expand;
            Layout.fillWidth: true;
            spacing: Style.spacing.small;

            TextLabel {
                label: "Security Type:";
                text: modelData.security;
            }

            TextLabel {
                label: "Strength";
                text: modelData.strength + "%";
            }

            TextLabel {
                label: "Bandwidth";
                text: modelData.bandwidth;
            }

            TextLabel {
                label: "Bonded:";
                text: modelData.bonded;
            }
        }
    }
}
