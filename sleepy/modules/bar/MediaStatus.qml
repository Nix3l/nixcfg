import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/cfg"
import "root:/services"
import "root:/style"
import "root:/components"

BarItem {
    id: root;

    visible: Media.playerOpen && Media.active.trackArtUrl;
    hovered: () => { GlobalState.drawers.media = true; }

    StyledIcon {
        visible: Media.playerOpen;
        source: Media.active.trackArtUrl;
    }

    StyledText {
        text: {
            if(Media.playerOpen) return (Media.active.trackArtist || Media.shortenedAlbumTitle) + "・" + Media.shortenedTrackTitle;
            else return "-- no active media --";
        }
    }
}
