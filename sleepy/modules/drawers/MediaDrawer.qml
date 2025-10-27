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

    property int padding: Style.padding.small;
    readonly property int contentHeight: implicitHeight - padding * 2;
    readonly property int contentWidth: implicitWidth - padding * 2;

    StyledBg {}

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

                    color: Style.colors.fg1;
                    font.pointSize: Style.text.large;
                }

                RowLayout {
                    visible: Media.playerOpen;
                    spacing: 2;
                    Layout.alignment: Qt.AlignCenter;

                    Text {
                        text: "・[";
                        color: Style.colors.acc1;
                        font.pointSize: Style.text.small;
                        font.bold: true;
                    }

                    Text {
                        visible: Media.playerOpen;
                        text: (Media.active.trackArtist == "" ? "" : (Media.active.trackArtist  + "・")) + Media.shortenedAlbumTitle;
                        color: Style.colors.fg1;
                        font.pointSize: Style.text.normal;
                    }

                    Text {
                        text: "]・";
                        color: Style.colors.acc1;
                        font.pointSize: Style.text.small;
                        font.bold: true;
                    }
                }

                RowLayout {
                    spacing: 4;
                    Text {
                        text: Media.cursorTimeText;
                        color: Style.colors.fg0;
                        font.pointSize: Style.text.smallest;
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
                        color: Style.colors.fg0;
                        font.pointSize: Style.text.smallest;
                    }
                }

                RowLayout {
                    spacing: 4;
                    Layout.alignment: Qt.AlignCenter;

                    IconButton {
                        source: Icons.media.rewind;
                        implicitSize: Style.icons.small;
                        clicked: () => { Media.active?.previous(); };
                    }

                    IconButton {
                        source: !Media.playing ? Icons.media.play : Icons.media.pause;
                        implicitSize: Style.icons.normal;
                        clicked: () => { Media.active?.togglePlaying(); };
                    }

                    IconButton {
                        source: Icons.media.fastforward;
                        implicitSize: Style.icons.small;
                        clicked: () => { Media.active?.next(); };
                    }
                }
            }
        }
    }
}
