import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts

import "root:/cfg"
import "root:/style"
import "root:/services"
import "root:/components"

BaseDrawer {
    id: root;

    isVisible: () => GlobalState.mediaDrawerOpen;
    toggle: (on) => { GlobalState.mediaDrawerOpen = on };

    // TODO: this is temporary. change this.
    implicitWidth: Math.max(500, implicitHeight + content.implicitWidth + padding * 2 + 12);
    implicitHeight: 120;

    xoffset: -40;

    property int padding: 8;
    readonly property int contentHeight: implicitHeight - padding * 2;
    readonly property int contentWidth: implicitWidth - padding * 2;

    Rectangle {
        anchors.fill: parent;
        color: Style.colors.bg0;
        border {
            width: 1;
            color: Style.colors.accent;
        }
    }

    Item {
        anchors.fill: parent;
        anchors.margins: root.padding;
        anchors.rightMargin: root.padding + 12; // so the spacing would match

        RowLayout {
            anchors.fill: parent;
            spacing: 16;

            IconImage {
                source: Media.playerOpen ? Media.active.trackArtUrl : Icons.media.music;
                mipmap: true;
                implicitSize: root.contentHeight;
            }

            ColumnLayout {
                id: content;
                Layout.alignment: Qt.AlignCenter;
                Layout.fillHeight: true;
                Layout.fillWidth: true;

                Text {
                    Layout.alignment: Qt.AlignCenter;
                    text: {
                        if(Media.playerOpen) return Media.shortenedTrackTitle;
                        else return "No Active Media";
                    }

                    color: Style.colors.fg;
                    font.pixelSize: 22;
                }

                RowLayout {
                    visible: Media.playerOpen;
                    spacing: 2;
                    Layout.alignment: Qt.AlignCenter;

                    Text {
                        text: "・[";
                        color: Style.colors.accent;
                        font.pixelSize: 12;
                        font.bold: true;
                    }

                    Text {
                        visible: Media.playerOpen;
                        text: (Media.active.trackArtist == "" ? "" : (Media.active.trackArtist  + "・")) + Media.shortenedAlbumTitle;
                        color: Style.colors.fg;
                        font.pixelSize: 16;
                    }

                    Text {
                        text: "]・";
                        color: Style.colors.accent;
                        font.pixelSize: 12;
                        font.bold: true;
                    }
                }

                RowLayout {
                    spacing: 4;
                    Text {
                        text: Media.cursorTimeText;
                        color: Style.colors.fgMuted;
                        font.pixelSize: 11;
                    }

                    CustomSlider {
                        Layout.fillWidth: true;
                        getPosition: () => { return Media.playerOpen ? Media.active.position / Media.active.length : 0; };
                        setPosition: (val) => {
                            if(!Media.playerOpen) return;
                            Media.active.position = val * Media.active.length;
                            Media.active.positionChanged();
                        };
                    }

                    Text {
                        text: Media.lengthText;
                        color: Style.colors.fgMuted;
                        font.pixelSize: 11;
                    }
                }

                RowLayout {
                    spacing: 4;
                    Layout.alignment: Qt.AlignCenter;

                    IconButton {
                        source: Icons.media.rewind;
                        implicitSize: 13;
                        clicked: () => { Media.active?.previous(); };
                    }

                    IconButton {
                        source: !Media.playing ? Icons.media.play : Icons.media.pause;
                        implicitSize: 16;
                        clicked: () => { Media.active?.togglePlaying(); };
                    }

                    IconButton {
                        source: Icons.media.fastforward;
                        implicitSize: 13;
                        clicked: () => { Media.active?.next(); };
                    }
                }
            }
        }
    }
}
