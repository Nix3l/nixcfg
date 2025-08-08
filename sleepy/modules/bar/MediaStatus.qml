import Quickshell
import Quickshell.Widgets
import QtQuick

import "root:/cfg"
import "root:/services"
import "root:/style"
import "root:/util"

BarItem {
    id: root;

    hovered: () => { GlobalState.mediaDrawerOpen = true; };

    IconWithBorder {
        visible: Media.playerOpen;
        source: Media.active.trackArtUrl;
        iconSize: 16;
        border: 2;
        borderColor: Style.colors.accent;
    }

    Text {
        text: {
            if(Media.playerOpen) return Media.active.trackArtist + "・" + Media.shortenedTrackTitle;
            else return "-- no active media --";
        }

        color: Style.colors.fg;
    }
}
