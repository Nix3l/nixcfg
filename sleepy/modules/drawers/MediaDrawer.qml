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

    isVisible: () => GlobalState.drawers.media;
    toggle: (on) => { GlobalState.drawers.media = on }

    // TODO: this is temporary. change this.
    implicitWidth: Math.max(500, implicitHeight + content.implicitWidth + padding * 2 + 12);
    implicitHeight: 120;

    xoffset: -40;

    readonly property int contentHeight: implicitHeight - padding * 2;
    readonly property int contentWidth: implicitWidth - padding * 2;

    Item {
        anchors.fill: parent;
        anchors.margins: root.padding;
        anchors.rightMargin: root.padding + 12; // so the spacing would match
                                                // TODO(nix3l): fix this

        RowLayout {
            anchors.fill: parent;
            spacing: Style.spacing.largest;

            StyledIcon {
                source: Media.playerOpen ? Media.active.trackArtUrl : Icons.media.music;
                implicitSize: root.contentHeight;
            }

            ColumnLayout {
                id: content;
                Layout.alignment: Qt.AlignCenter;
                Layout.fillHeight: true;
                Layout.fillWidth: true;

                StyledText {
                    Layout.alignment: Qt.AlignCenter;
                    text: {
                        if(Media.playerOpen) return Media.shortenedTrackTitle;
                        else return "No Active Media";
                    }

                    font.pointSize: Style.text.large;
                }

                RowLayout {
                    visible: Media.playerOpen;
                    spacing: Style.spacing.smallest;
                    Layout.alignment: Qt.AlignCenter;

                    StyledText {
                        text: "・[";
                        color: Style.colors.acc1;
                        font.pointSize: Style.text.small;
                        font.bold: true;
                    }

                    StyledText {
                        visible: Media.playerOpen;
                        text: (Media.active.trackArtist == "" ? "" : (Media.active.trackArtist  + "・")) + Media.shortenedAlbumTitle;
                        font.pointSize: Style.text.normal;
                    }

                    StyledText {
                        text: "]・";
                        color: Style.colors.acc1;
                        font.pointSize: Style.text.small;
                        font.bold: true;
                    }
                }

                RowLayout {
                    spacing: Style.spacing.small;
                    StyledText {
                        text: Media.cursorTimeText;
                        color: Style.colors.fg0;
                        font.pointSize: Style.text.smallest;
                    }

                    CustomSlider {
                        Layout.fillWidth: true;
                        getPosition: () => { return Media.playerOpen ? Media.active.position / Media.active.length : 0; }
                        setPosition: (val) => {
                            if(!Media.playerOpen) return;
                            Media.active.position = val * Media.active.length;
                            Media.active.positionChanged();
                        }
                    }

                    StyledText {
                        text: Media.lengthText;
                        color: Style.colors.fg0;
                        font.pointSize: Style.text.smallest;
                    }
                }

                RowLayout {
                    spacing: Style.spacing.small;
                    Layout.alignment: Qt.AlignCenter;

                    IconButton {
                        icon: Icons.media.rewind;
                        iconSize: Style.icons.small;
                        clicked: () => { Media.active?.previous(); }
                    }

                    IconButton {
                        icon: !Media.playing ? Icons.media.play : Icons.media.pause;
                        iconSize: Style.icons.normal;
                        clicked: () => { Media.active?.togglePlaying(); }
                    }

                    IconButton {
                        icon: Icons.media.fastforward;
                        iconSize: Style.icons.small;
                        clicked: () => { Media.active?.next(); }
                    }
                }
            }
        }
    }
}
