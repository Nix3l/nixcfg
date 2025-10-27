import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

import "root:/cfg"
import "root:/style"
import "root:/services"
import "root:/components"
import "root:/modules/drawers"

BaseDrawer {
    id: root;

    isVisible: () => GlobalState.dashboardDrawerOpen;
    toggle: (on) => { GlobalState.dashboardDrawerOpen = on };

    xoffset: anchorItem.width / 2;

    property int padding: 8;

    implicitWidth: 480;
    implicitHeight: content.implicitHeight + root.padding * 2;

    ColumnLayout {
        id: content;
        anchors.fill: parent;
        anchors.margins: root.padding;

        RowLayout {
            Layout.fillWidth: true;
            Layout.alignment: Qt.AlignTop;
            spacing: root.padding;

            IconImage {
                id: pfp;
                Layout.alignment: Qt.AlignLeft;
                source: Paths.pfpFile;
                implicitSize: powerGrid.implicitWidth;
                mipmap: true;
                onStatusChanged: if(pfp.status == Image.Error) pfp.visible = false;
            }

            Item {
                Layout.fillWidth: true;
                Layout.fillHeight: true;

                GridLayout {
                    anchors.centerIn: parent;

                    rows: 2;
                    columns: 2;

                    StyledText {
                        Layout.row: 0;
                        Layout.column: 0;
                        text: Time.format("hh:mm");
                        color: Style.colors.fg1;
                        font.pointSize: Style.text.colossal;
                    }

                    ColumnLayout {
                        Layout.row: 0;
                        Layout.column: 1;
                        Layout.alignment: Qt.AlignLeft;

                        StyledText {
                            text: Time.format("ap");
                            color: Style.colors.fg1;
                            font.pointSize: Style.text.small;
                        }

                        StyledText {
                            text: Time.format("ss");
                            color: Style.colors.fg1;
                            font.pointSize: Style.text.large;
                        }
                    }

                    StyledText {
                        Layout.row: 1;
                        Layout.column: 0;
                        Layout.columnSpan: 2;
                        Layout.alignment: Qt.AlignCenter;

                        text: Time.format("dddd, dd/MM/yy");
                        color: Style.colors.fg1;
                        font.pointSize: Style.text.normal;
                    }
                }
            }
        }

        RowLayout {
            Layout.fillWidth: true;
            Layout.fillHeight: true;
            Layout.alignment: Qt.AlignBottom;
            spacing: root.padding;

            GridLayout {
                id: powerGrid;

                Layout.fillHeight: true;
                Layout.alignment: Qt.AlignLeft;

                rows: 2;
                columns: 3;

                PowerButton {
                    Layout.row: 0;
                    Layout.column: 0;
                    Layout.alignment: Qt.AlignCenter;
                    icon: Icons.power.poweroff;
                    leftClicked: () => { Power.poweroff(); };
                }

                PowerButton {
                    Layout.row: 0;
                    Layout.column: 1;
                    Layout.alignment: Qt.AlignCenter;
                    icon: Icons.power.reboot;
                    leftClicked: () => { Power.reboot(); };
                }

                PowerButton {
                    Layout.row: 1;
                    Layout.column: 0;
                    Layout.alignment: Qt.AlignCenter;
                    icon: Icons.power.logout;
                    leftClicked: () => { Power.logout(); };
                }

                PowerButton {
                    Layout.row: 1;
                    Layout.column: 1;
                    Layout.alignment: Qt.AlignCenter;
                    icon: Icons.power.sleep;
                    leftClicked: () => { Power.sleep(); };
                }

                DashboardSlider {
                    Layout.row: 0;
                    Layout.column: 2;
                    Layout.fillWidth: true;
                    Layout.fillHeight: true;

                    icon: Audio.muted() ? Icons.audio.vol_mute : Icons.volIcon(Audio.volume());
                    iconSize: Style.icons.largest;
                    iconLeftClicked: () => { Audio.toggleMuted(); };

                    getPosition: () => Audio.volume();
                    setPosition: (val) => { Audio.setVolume(Math.round(val * 100) / 100); };
                }

                DashboardSlider {
                    Layout.row: 1;
                    Layout.column: 2;
                    Layout.fillWidth: true;
                    Layout.fillHeight: true;

                    icon: Icons.display.brightness;
                    iconSize: Style.icons.largest;

                    sliderStepSize: 0.05;
                    getPosition: () => Brightness.brightness / Brightness.maxBrightness;
                    setPosition: (val) => { Brightness.setBrightness(val * Brightness.maxBrightness); };
                }
            }
        }
    }
}
